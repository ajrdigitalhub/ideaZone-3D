const express = require('express');
const fs = require('fs');
const path = require('path');
const AdmZip = require('adm-zip');
const multer = require('multer');
const pool = require('../db');
const { adminAuth } = require('../middleware/auth');
const { bucket } = require('../firebase');

const router = express.Router();
const backupsDir = path.join(__dirname, '../uploads/backups');

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 100 * 1024 * 1024 } // 100MB limit
});

// Ensure local backups directory exists
if (!fs.existsSync(backupsDir)) {
  fs.mkdirSync(backupsDir, { recursive: true });
}

/**
 * Initialize Backup DB Tables and Default Settings
 * Weekly twice at 02:00 AM Asia/Kolkata, stored in Firebase Storage "backups/" folder, max 10 files.
 */
async function initBackupTables() {
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS database_backups (
        id VARCHAR(255) PRIMARY KEY,
        filename VARCHAR(255) NOT NULL,
        type VARCHAR(50) NOT NULL DEFAULT 'MANUAL',
        status VARCHAR(50) NOT NULL DEFAULT 'Success',
        table_count INTEGER DEFAULT 0,
        row_count INTEGER DEFAULT 0,
        size_bytes BIGINT DEFAULT 0,
        execution_duration_ms INTEGER DEFAULT 0,
        storage_type VARCHAR(50) DEFAULT 'Firebase Storage',
        error_message TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );

      CREATE TABLE IF NOT EXISTS backup_settings (
        key VARCHAR(50) PRIMARY KEY DEFAULT 'default',
        auto_enabled BOOLEAN DEFAULT true,
        frequency VARCHAR(50) DEFAULT 'TWICE_WEEKLY',
        run_days JSONB DEFAULT '["Monday", "Thursday"]'::jsonb,
        execution_time VARCHAR(10) DEFAULT '02:00',
        timezone VARCHAR(100) DEFAULT 'Asia/Kolkata',
        retention_count INTEGER DEFAULT 10,
        cloud_storage_path VARCHAR(255) DEFAULT 'backups',
        auto_download_enabled BOOLEAN DEFAULT true,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    // Insert or update default settings
    await pool.query(`
      INSERT INTO backup_settings (key, auto_enabled, frequency, run_days, execution_time, timezone, retention_count, cloud_storage_path, auto_download_enabled)
      VALUES ('default', true, 'TWICE_WEEKLY', '["Monday", "Thursday"]'::jsonb, '02:00', 'Asia/Kolkata', 10, 'backups', true)
      ON CONFLICT (key) DO UPDATE SET
        retention_count = 10,
        cloud_storage_path = 'backups',
        frequency = 'TWICE_WEEKLY',
        run_days = '["Monday", "Thursday"]'::jsonb,
        execution_time = '02:00',
        auto_enabled = true;
    `);
  } catch (err) {
    console.error('Error initializing backup tables:', err);
  }
}

initBackupTables();

/**
 * Generate complete PostgreSQL database snapshot (.zip containing .sql dump and manifest.json)
 * and upload to Firebase Storage under "backups/" folder
 */
async function createDatabaseBackup(type = 'MANUAL') {
  const startTime = Date.now();
  const backupId = `BK-${Date.now()}-${Math.random().toString(36).substring(2, 8).toUpperCase()}`;
  const timestampStr = new Date().toISOString().replace(/[:.]/g, '-');
  const filename = `backup_${timestampStr}_${backupId}.zip`;
  const filePath = path.join(backupsDir, filename);

  try {
    // 1. Discover all tables in public schema dynamically
    const tablesRes = await pool.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
        AND table_name NOT IN ('database_backups', 'backup_settings')
      ORDER BY table_name;
    `);

    const tables = tablesRes.rows.map(r => r.table_name);
    let totalRows = 0;
    const tableDetails = [];

    let sqlContent = `-- IDEAZONE 3D PostgreSQL Snapshot Backup\n`;
    sqlContent += `-- Generated: ${new Date().toISOString()}\n`;
    sqlContent += `-- Backup ID: ${backupId}\n`;
    sqlContent += `-- Type: ${type}\n`;
    sqlContent += `-- Tables count: ${tables.length}\n\n`;
    sqlContent += `SET statement_timeout = 0;\n`;
    sqlContent += `SET client_encoding = 'UTF8';\n`;
    sqlContent += `SET standard_conforming_strings = on;\n`;
    sqlContent += `SET session_replication_role = 'replica';\n\n`;

    for (const table of tables) {
      // Fetch table schema DDL (columns)
      const colsRes = await pool.query(`
        SELECT column_name, data_type, is_nullable, column_default
        FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = $1
        ORDER BY ordinal_position;
      `, [table]);

      const columns = colsRes.rows;
      if (columns.length === 0) continue;

      // Fetch primary key columns
      const pkRes = await pool.query(`
        SELECT kcu.column_name
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu
          ON tc.constraint_name = kcu.constraint_name
          AND tc.table_schema = kcu.table_schema
        WHERE tc.table_schema = 'public' 
          AND tc.table_name = $1 
          AND tc.constraint_type = 'PRIMARY KEY'
        ORDER BY kcu.ordinal_position;
      `, [table]);
      const pkCols = pkRes.rows.map(r => `"${r.column_name}"`);

      sqlContent += `-- Table: ${table}\n`;
      sqlContent += `CREATE TABLE IF NOT EXISTS "${table}" (\n`;

      const colDefs = columns.map(c => {
        let def = `  "${c.column_name}" ${c.data_type.toUpperCase()}`;
        if (c.column_default) def += ` DEFAULT ${c.column_default}`;
        if (c.is_nullable === 'NO') def += ` NOT NULL`;
        return def;
      });

      if (pkCols.length > 0) {
        colDefs.push(`  PRIMARY KEY (${pkCols.join(', ')})`);
      }

      sqlContent += colDefs.join(',\n') + `\n);\n`;
      sqlContent += `TRUNCATE TABLE "${table}" CASCADE;\n\n`;

      // Fetch table rows
      const dataRes = await pool.query(`SELECT * FROM "${table}"`);
      const rows = dataRes.rows;
      totalRows += rows.length;
      tableDetails.push({ table, rowCount: rows.length });

      if (rows.length > 0) {
        const colNames = columns.map(c => `"${c.column_name}"`).join(', ');
        sqlContent += `-- Inserting ${rows.length} rows into "${table}"\n`;

        for (const row of rows) {
          const values = columns.map(col => {
            const val = row[col.column_name];
            if (val === null || val === undefined) return 'NULL';
            if (typeof val === 'boolean') return val ? 'TRUE' : 'FALSE';
            if (typeof val === 'number') return val;
            if (val instanceof Date) return `'${val.toISOString()}'`;
            if (typeof val === 'object') return `'${JSON.stringify(val).replace(/'/g, "''")}'`;
            return `'${String(val).replace(/'/g, "''")}'`;
          });
          sqlContent += `INSERT INTO "${table}" (${colNames}) VALUES (${values.join(', ')});\n`;
        }
        sqlContent += `\n`;
      }

      // If table has an 'id' column and a serial sequence, setval to current max
      const hasIdCol = columns.some(c => c.column_name === 'id');
      if (hasIdCol) {
        try {
          const seqRes = await pool.query(`SELECT pg_get_serial_sequence($1, 'id') AS seq_name;`, [table]);
          if (seqRes.rows[0]?.seq_name) {
            sqlContent += `SELECT setval(pg_get_serial_sequence('"${table}"', 'id'), COALESCE((SELECT MAX("id") FROM "${table}"), 1), true);\n\n`;
          }
        } catch (seqErr) {
          // Ignore sequence lookup errors
        }
      }
    }

    sqlContent += `SET session_replication_role = 'origin';\n`;

    const executionDuration = Date.now() - startTime;

    // Build ZIP archive containing backup_dump.sql and manifest.json
    const manifest = {
      backupId,
      timestamp: new Date().toISOString(),
      type,
      database: 'PostgreSQL',
      tableCount: tables.length,
      totalRows,
      tables: tableDetails
    };

    const zip = new AdmZip();
    zip.addFile('backup_dump.sql', Buffer.from(sqlContent, 'utf8'));
    zip.addFile('manifest.json', Buffer.from(JSON.stringify(manifest, null, 2), 'utf8'));
    zip.writeZip(filePath);

    const zipBuffer = zip.toBuffer();
    const sizeBytes = zipBuffer.length;

    // Upload ZIP snapshot directly to Firebase Storage under "backups/" folder
    let storageType = 'Firebase Storage';
    if (bucket) {
      try {
        const cloudDestination = `backups/${filename}`;
        console.log(`[Backup Engine] Uploading ZIP snapshot to Firebase Storage: ${cloudDestination}...`);
        await bucket.upload(filePath, {
          destination: cloudDestination,
          metadata: {
            contentType: 'application/zip',
            metadata: {
              backupId,
              type,
              tableCount: String(tables.length),
              rowCount: String(totalRows),
              createdAt: new Date().toISOString()
            }
          }
        });
        console.log(`[Backup Engine] Successfully stored ZIP in Firebase Storage: ${cloudDestination}`);
      } catch (uploadErr) {
        console.error('[Backup Engine] Firebase Storage upload error:', uploadErr.message);
        storageType = 'Local Disk';
      }
    } else {
      console.warn('[Backup Engine] Firebase Storage bucket unavailable. Stored on local disk.');
      storageType = 'Local Disk';
    }

    // Store log in database_backups table
    const record = {
      id: backupId,
      filename,
      type,
      status: 'Success',
      table_count: tables.length,
      row_count: totalRows,
      size_bytes: sizeBytes,
      execution_duration_ms: executionDuration,
      storage_type: storageType,
      error_message: null
    };

    await pool.query(`
      INSERT INTO database_backups (id, filename, type, status, table_count, row_count, size_bytes, execution_duration_ms, storage_type, error_message, created_at)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW())
    `, [record.id, record.filename, record.type, record.status, record.table_count, record.row_count, record.size_bytes, record.execution_duration_ms, record.storage_type, record.error_message]);

    // Apply strict retention pruning (max 10 files maintained in Firebase Storage and locally)
    await applyRetentionPolicy();

    return record;
  } catch (err) {
    console.error('Backup creation failed:', err);
    const executionDuration = Date.now() - startTime;
    const failedRecord = {
      id: backupId,
      filename: `failed_${backupId}.zip`,
      type,
      status: 'Failed',
      table_count: 0,
      row_count: 0,
      size_bytes: 0,
      execution_duration_ms: executionDuration,
      storage_type: 'Local Disk',
      error_message: err.message
    };

    await pool.query(`
      INSERT INTO database_backups (id, filename, type, status, table_count, row_count, size_bytes, execution_duration_ms, storage_type, error_message, created_at)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW())
    `, [failedRecord.id, failedRecord.filename, failedRecord.type, failedRecord.status, failedRecord.table_count, failedRecord.row_count, failedRecord.size_bytes, failedRecord.execution_duration_ms, failedRecord.storage_type, failedRecord.error_message]).catch(() => {});

    throw err;
  }
}

/**
 * Helper to parse SQL and Manifest from a file buffer (ZIP or SQL)
 */
function parseBackupBuffer(buffer, originalFilename = '') {
  const isZip = originalFilename.toLowerCase().endsWith('.zip') || (buffer[0] === 0x50 && buffer[1] === 0x4B);
  let sqlScript = '';
  let manifest = null;

  if (isZip) {
    const zip = new AdmZip(buffer);
    const entries = zip.getEntries();

    // Look for manifest.json
    const manifestEntry = entries.find(e => e.entryName.toLowerCase().endsWith('manifest.json'));
    if (manifestEntry) {
      try {
        manifest = JSON.parse(manifestEntry.getData().toString('utf8'));
      } catch (e) {
        console.warn('[Backup Parser] Failed to parse manifest.json from ZIP:', e.message);
      }
    }

    // Look for .sql file
    const sqlEntry = entries.find(e => e.entryName.toLowerCase().endsWith('.sql'));
    if (!sqlEntry) {
      throw new Error('No .sql database snapshot file found inside the ZIP archive');
    }
    sqlScript = sqlEntry.getData().toString('utf8');
  } else {
    // Plain SQL file
    sqlScript = buffer.toString('utf8');
  }

  // If manifest not in zip or file is legacy .sql, dynamically extract tables and row counts
  if (!manifest || !manifest.tables || manifest.tables.length === 0) {
    const tablesFound = [];
    const tableRegex = /CREATE TABLE IF NOT EXISTS "([^"]+)"/g;
    let match;
    while ((match = tableRegex.exec(sqlScript)) !== null) {
      const tableName = match[1];
      const insertRegex = new RegExp(`INSERT INTO "${tableName}"`, 'g');
      const insertMatches = sqlScript.match(insertRegex);
      const rowCount = insertMatches ? insertMatches.length : 0;
      tablesFound.push({ table: tableName, rowCount });
    }
    manifest = {
      tableCount: tablesFound.length,
      totalRows: tablesFound.reduce((sum, t) => sum + t.rowCount, 0),
      tables: tablesFound
    };
  }

  return { sqlScript, manifest, isZip };
}

/**
 * Execute restore inside transactional block with session_replication_role = replica
 * and reset PostgreSQL serial sequences for restored tables
 */
async function executeRestoreTransaction(sqlScript, manifest) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    await client.query("SET session_replication_role = 'replica'");
    await client.query(sqlScript);
    await client.query("SET session_replication_role = 'origin'");

    // Synchronize serial sequences for all restored tables
    if (manifest && manifest.tables) {
      for (const item of manifest.tables) {
        try {
          const seqRes = await client.query(
            `SELECT pg_get_serial_sequence('"' || $1 || '"', 'id') AS seq`,
            [item.table]
          );
          const seqName = seqRes.rows[0]?.seq;
          if (seqName) {
            await client.query(
              `SELECT setval($1, COALESCE((SELECT MAX(id) FROM "${item.table}"), 0) + 1, false)`,
              [seqName]
            );
          }
        } catch (e) {
          // Table doesn't have an 'id' column or is not a sequence, safely ignore
        }
      }
    }

    await client.query('COMMIT');
  } catch (restoreErr) {
    try {
      await client.query("SET session_replication_role = 'origin'");
    } catch (e) {}
    await client.query('ROLLBACK');
    throw restoreErr;
  } finally {
    client.release();
  }
}

/**
 * Helper to fetch backup file buffer and extract SQL and Manifest (supports .zip and .sql)
 */
async function getBackupSqlAndManifest(backup) {
  const filePath = path.join(backupsDir, backup.filename);
  let buffer = null;

  if (fs.existsSync(filePath)) {
    buffer = fs.readFileSync(filePath);
  } else if (bucket) {
    const cloudFile = bucket.file(`backups/${backup.filename}`);
    const [exists] = await cloudFile.exists();
    if (exists) {
      console.log(`[Backup Engine] Downloading backup from Firebase Storage: backups/${backup.filename}`);
      const [cloudBuf] = await cloudFile.download();
      buffer = cloudBuf;
      try { fs.writeFileSync(filePath, buffer); } catch (e) {}
    }
  }

  if (!buffer) {
    throw new Error('Backup file not found on local disk or Firebase Storage');
  }

  const { sqlScript, manifest, isZip } = parseBackupBuffer(buffer, backup.filename);
  if (manifest) {
    manifest.backupId = backup.id;
    manifest.timestamp = backup.created_at;
    manifest.type = backup.type;
  }
  return { sqlScript, manifest, isZip };
}

/**
 * Apply retention policy: retain maximum 10 latest backup files, prune older ones
 */
async function applyRetentionPolicy() {
  try {
    const settingsRes = await pool.query(`SELECT retention_count FROM backup_settings WHERE key = 'default'`);
    const retentionCount = settingsRes.rows[0]?.retention_count || 10;

    const allBackupsRes = await pool.query(`
      SELECT id, filename FROM database_backups 
      ORDER BY created_at DESC
    `);
    const allBackups = allBackupsRes.rows;

    if (allBackups.length > retentionCount) {
      const toDelete = allBackups.slice(retentionCount);
      console.log(`[Retention] Pruning ${toDelete.length} excess backups beyond retention limit (${retentionCount})`);

      for (const item of toDelete) {
        // 1. Delete from local disk
        const localPath = path.join(backupsDir, item.filename);
        if (fs.existsSync(localPath)) {
          try {
            fs.unlinkSync(localPath);
            console.log(`[Retention] Deleted local file: ${item.filename}`);
          } catch (e) {}
        }

        // 2. Delete from Firebase Storage
        if (bucket) {
          try {
            await bucket.file(`backups/${item.filename}`).delete({ ignoreNotFound: true });
            console.log(`[Retention] Deleted Firebase Storage file: backups/${item.filename}`);
          } catch (e) {}
        }

        // 3. Delete from DB
        await pool.query(`DELETE FROM database_backups WHERE id = $1`, [item.id]);
      }
    }

    // Direct cloud bucket check to prune unindexed older files in "backups/" folder
    if (bucket) {
      try {
        const [cloudFiles] = await bucket.getFiles({ prefix: 'backups/' });
        const validFiles = cloudFiles
          .filter(f => f.name !== 'backups/' && (f.name.endsWith('.zip') || f.name.endsWith('.sql')))
          .sort((a, b) => new Date(b.metadata.timeCreated || 0) - new Date(a.metadata.timeCreated || 0));

        if (validFiles.length > retentionCount) {
          const excessFiles = validFiles.slice(retentionCount);
          for (const file of excessFiles) {
            await file.delete({ ignoreNotFound: true }).catch(() => {});
            console.log(`[Retention] Pruned excess Firebase Storage file: ${file.name}`);
          }
        }
      } catch (storageScanErr) {
        console.error('[Retention] Error during cloud storage cleanup:', storageScanErr.message);
      }
    }
  } catch (err) {
    console.error('Error applying backup retention policy:', err.message);
  }
}

/**
 * Background Cron Runner for Scheduled Twice-Weekly Backups at 02:00 AM Asia/Kolkata
 */
let lastCronRunSlot = '';

async function checkAndRunCron() {
  try {
    const settingsRes = await pool.query(`SELECT * FROM backup_settings WHERE key = 'default'`);
    if (settingsRes.rows.length === 0) return;
    const settings = settingsRes.rows[0];

    if (!settings.auto_enabled) return;

    // Current time in specified timezone (default Asia/Kolkata)
    const tz = settings.timezone || 'Asia/Kolkata';
    const now = new Date();
    const dayFormatter = new Intl.DateTimeFormat('en-US', { timeZone: tz, weekday: 'long' });
    const timeFormatter = new Intl.DateTimeFormat('en-US', { timeZone: tz, hour: '2-digit', minute: '2-digit', hour12: false });

    const currentDay = dayFormatter.format(now);
    const currentTime = timeFormatter.format(now);
    const dateStr = now.toISOString().split('T')[0];

    let runDays = [];
    if (Array.isArray(settings.run_days)) {
      runDays = settings.run_days;
    } else if (typeof settings.run_days === 'string') {
      try { runDays = JSON.parse(settings.run_days); } catch (e) {}
    }

    if (runDays.length === 0) {
      runDays = ['Monday', 'Thursday'];
    }

    const targetTime = settings.execution_time || '02:00';
    const currentSlot = `${dateStr}_${currentDay}_${currentTime}_${settings.frequency}`;

    if (currentSlot === lastCronRunSlot) return;

    const shouldRun = runDays.includes(currentDay) && currentTime === targetTime;

    if (shouldRun) {
      console.log(`[Backup Cron] Triggering scheduled ${settings.frequency} backup at ${currentTime} for slot: ${currentSlot}`);
      lastCronRunSlot = currentSlot;
      await createDatabaseBackup('SCHEDULED');
    }
  } catch (err) {
    console.error('Error in backup cron runner:', err.message);
  }
}

// Start background cron runner interval (checks every 30 seconds)
setInterval(checkAndRunCron, 30000);

// --- REST API ENDPOINTS ---

/**
 * GET /api/backups/stats
 * Overview cards
 */
router.get('/stats', adminAuth, async (req, res, next) => {
  try {
    const settingsRes = await pool.query(`SELECT * FROM backup_settings WHERE key = 'default'`);
    const settings = settingsRes.rows[0] || {};

    const lastSuccessRes = await pool.query(`
      SELECT * FROM database_backups 
      WHERE status = 'Success' 
      ORDER BY created_at DESC 
      LIMIT 1
    `);

    const tablesCountRes = await pool.query(`
      SELECT COUNT(*) as count FROM information_schema.tables 
      WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
    `);
    const dbTableCount = parseInt(tablesCountRes.rows[0]?.count || 0);

    const backupsCountRes = await pool.query(`SELECT COUNT(*) as count FROM database_backups`);
    const totalBackups = parseInt(backupsCountRes.rows[0]?.count || 0);

    const lastBackup = lastSuccessRes.rows[0] || null;

    res.json({
      dbOnline: true,
      backupHealth: lastBackup ? 'HEALTHY' : 'NOTICE',
      lastBackup,
      dbTableCount,
      totalBackups,
      settings: {
        auto_enabled: settings.auto_enabled ?? true,
        frequency: settings.frequency || 'TWICE_WEEKLY',
        run_days: settings.run_days || ['Monday', 'Thursday'],
        execution_time: settings.execution_time || '02:00',
        timezone: settings.timezone || 'Asia/Kolkata',
        retention_count: settings.retention_count || 10,
        cloud_storage_path: settings.cloud_storage_path || 'backups',
        auto_download_enabled: settings.auto_download_enabled ?? true
      }
    });
  } catch (err) {
    next(err);
  }
});

/**
 * GET /api/backups/history
 * List preserved backup logs
 */
router.get('/history', adminAuth, async (req, res, next) => {
  try {
    const { type, status } = req.query;
    let query = `SELECT * FROM database_backups WHERE 1=1`;
    const params = [];

    if (type && type !== 'ALL') {
      params.push(type.toUpperCase());
      query += ` AND type = $${params.length}`;
    }
    if (status && status !== 'ALL') {
      params.push(status);
      query += ` AND status = $${params.length}`;
    }

    query += ` ORDER BY created_at DESC`;

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

/**
 * POST /api/backups/create
 * Trigger manual backup creation (creates .zip archive and uploads to Firebase Storage)
 */
router.post('/create', adminAuth, async (req, res, next) => {
  try {
    const backup = await createDatabaseBackup('MANUAL');
    res.json({
      message: 'Database backup (.zip archive) created and stored in Firebase Storage successfully',
      backup
    });
  } catch (err) {
    console.error('Backup creation error:', err);
    res.status(500).json({ message: 'Backup creation failed', error: err.message });
  }
});

/**
 * POST /api/backups/upload
 * Upload a .zip backup archive (or .sql dump), analyze impact against live database, and stage for restore
 */
router.post('/upload', adminAuth, upload.single('file'), async (req, res, next) => {
  try {
    if (!req.file || !req.file.buffer) {
      return res.status(400).json({ message: 'No backup file provided in upload.' });
    }

    const originalName = req.file.originalname || 'uploaded_backup.zip';
    const buffer = req.file.buffer;
    const isZip = originalName.toLowerCase().endsWith('.zip') || (buffer[0] === 0x50 && buffer[1] === 0x4B);
    const isSql = originalName.toLowerCase().endsWith('.sql');

    if (!isZip && !isSql) {
      return res.status(400).json({ message: 'Invalid file format. Please upload a .zip archive or .sql dump.' });
    }

    const { sqlScript, manifest } = parseBackupBuffer(buffer, originalName);

    if (!manifest.tables || manifest.tables.length === 0) {
      return res.status(400).json({ message: 'The uploaded file does not contain valid database table schemas or records.' });
    }

    // Compare with live database to generate impact assessment
    const tableImpacts = [];
    let currentTotalRows = 0;

    for (const item of manifest.tables) {
      let currentRows = 0;
      let existsInCurrentDb = false;
      try {
        const countRes = await pool.query(`SELECT COUNT(*) as count FROM "${item.table}"`);
        currentRows = parseInt(countRes.rows[0]?.count || 0, 10);
        existsInCurrentDb = true;
      } catch (e) {
        existsInCurrentDb = false;
      }

      currentTotalRows += currentRows;
      const rowDiff = item.rowCount - currentRows;

      let status = 'WILL_OVERWRITE';
      if (!existsInCurrentDb) {
        status = 'NEW_TABLE';
      } else if (rowDiff === 0) {
        status = 'MATCHES';
      } else if (rowDiff > 0) {
        status = `ADDS_${rowDiff}`;
      } else {
        status = `REDUCES_${Math.abs(rowDiff)}`;
      }

      tableImpacts.push({
        table: item.table,
        snapshotRows: item.rowCount,
        currentRows,
        diff: rowDiff,
        exists: existsInCurrentDb,
        status
      });
    }

    // Persist file locally and in Firebase Storage under backups/
    const backupId = `BK-${Date.now()}-${Math.random().toString(36).substring(2, 8).toUpperCase()}`;
    const ext = isZip ? '.zip' : '.sql';
    const now = new Date();
    const dateStr = now.toISOString().replace(/[:.]/g, '-');
    const filename = `backup_${dateStr}_${backupId}${ext}`;
    const localFilePath = path.join(backupsDir, filename);

    fs.writeFileSync(localFilePath, buffer);

    let storageType = 'Local Disk';
    if (bucket) {
      try {
        const cloudFile = bucket.file(`backups/${filename}`);
        await cloudFile.save(buffer, {
          metadata: {
            contentType: isZip ? 'application/zip' : 'application/sql',
            metadata: {
              backupId,
              type: 'UPLOADED',
              originalName,
              tableCount: String(manifest.tables.length),
              rowCount: String(manifest.totalRows)
            }
          }
        });
        storageType = 'Firebase Storage';
        console.log(`[Backup Engine] Uploaded backup preserved in Firebase Storage: backups/${filename}`);
      } catch (cloudErr) {
        console.error('[Backup Engine] Failed to upload to Firebase Storage:', cloudErr.message);
      }
    }

    const insertQuery = `
      INSERT INTO database_backups (
        id, filename, type, status, table_count, row_count, size_bytes, execution_duration_ms, storage_type, created_at
      ) VALUES ($1, $2, 'UPLOADED', 'Success', $3, $4, $5, 0, $6, NOW())
      RETURNING *
    `;
    const dbRes = await pool.query(insertQuery, [
      backupId,
      filename,
      manifest.tables.length,
      manifest.totalRows,
      buffer.length,
      storageType
    ]);

    const savedBackup = dbRes.rows[0];

    // Maintain max retention limit (prune oldest)
    await applyRetentionPolicy();

    res.json({
      message: 'Backup archive uploaded and analyzed successfully',
      backup: {
        id: savedBackup.id,
        filename: savedBackup.filename,
        created_at: savedBackup.created_at,
        type: 'UPLOADED',
        table_count: savedBackup.table_count,
        row_count: savedBackup.row_count,
        size_bytes: savedBackup.size_bytes,
        isZip,
        original_name: originalName
      },
      summary: {
        totalTablesInSnapshot: manifest.tables.length,
        totalSnapshotRows: manifest.totalRows,
        totalCurrentRows: currentTotalRows,
        netDifference: manifest.totalRows - currentTotalRows
      },
      tables: tableImpacts
    });
  } catch (err) {
    console.error('Upload backup error:', err);
    res.status(500).json({ message: 'Failed to process uploaded backup archive', error: err.message });
  }
});

/**
 * POST /api/backups/upload-restore
 * Directly upload and execute database restoration in one single request
 */
router.post('/upload-restore', adminAuth, upload.single('file'), async (req, res, next) => {
  try {
    if (!req.file || !req.file.buffer) {
      return res.status(400).json({ message: 'No backup file provided in upload.' });
    }

    const originalName = req.file.originalname || 'uploaded_backup.zip';
    const buffer = req.file.buffer;
    const isZip = originalName.toLowerCase().endsWith('.zip') || (buffer[0] === 0x50 && buffer[1] === 0x4B);

    const { sqlScript, manifest } = parseBackupBuffer(buffer, originalName);

    // Execute restore
    await executeRestoreTransaction(sqlScript, manifest);

    // Persist file record
    const backupId = `BK-${Date.now()}-${Math.random().toString(36).substring(2, 8).toUpperCase()}`;
    const ext = isZip ? '.zip' : '.sql';
    const now = new Date();
    const dateStr = now.toISOString().replace(/[:.]/g, '-');
    const filename = `backup_${dateStr}_${backupId}${ext}`;
    const localFilePath = path.join(backupsDir, filename);

    fs.writeFileSync(localFilePath, buffer);

    let storageType = 'Local Disk';
    if (bucket) {
      try {
        const cloudFile = bucket.file(`backups/${filename}`);
        await cloudFile.save(buffer, {
          metadata: {
            contentType: isZip ? 'application/zip' : 'application/sql',
            metadata: { backupId, type: 'UPLOADED', originalName }
          }
        });
        storageType = 'Firebase Storage';
      } catch (e) {}
    }

    const insertQuery = `
      INSERT INTO database_backups (
        id, filename, type, status, table_count, row_count, size_bytes, execution_duration_ms, storage_type, created_at
      ) VALUES ($1, $2, 'UPLOADED', 'Success', $3, $4, $5, 0, $6, NOW())
      RETURNING *
    `;
    const dbRes = await pool.query(insertQuery, [
      backupId,
      filename,
      manifest.tables.length,
      manifest.totalRows,
      buffer.length,
      storageType
    ]);

    await applyRetentionPolicy();

    res.json({
      message: `Database restored successfully from uploaded ${isZip ? 'ZIP archive' : 'SQL snapshot'}`,
      id: backupId,
      filename,
      restoredTables: manifest.tables.length,
      restoredRows: manifest.totalRows,
      tables: manifest.tables || []
    });
  } catch (err) {
    console.error('Direct upload restore error:', err);
    res.status(500).json({ message: 'Failed to restore uploaded backup archive', error: err.message });
  }
});

/**
 * GET /api/backups/impact/:id
 * Analyze affected tables and record counts BEFORE restoring snapshot
 */
router.get('/impact/:id', adminAuth, async (req, res, next) => {
  try {
    const result = await pool.query(`SELECT * FROM database_backups WHERE id = $1`, [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Backup record not found' });
    }

    const backup = result.rows[0];
    const { manifest, isZip } = await getBackupSqlAndManifest(backup);

    const tableImpacts = [];
    let currentTotalRows = 0;

    for (const item of manifest.tables) {
      let currentRows = 0;
      let existsInCurrentDb = false;
      try {
        const countRes = await pool.query(`SELECT COUNT(*) as count FROM "${item.table}"`);
        currentRows = parseInt(countRes.rows[0]?.count || 0, 10);
        existsInCurrentDb = true;
      } catch (e) {
        existsInCurrentDb = false;
      }

      currentTotalRows += currentRows;
      const rowDiff = item.rowCount - currentRows;

      let status = 'WILL_OVERWRITE';
      if (!existsInCurrentDb) {
        status = 'NEW_TABLE';
      } else if (rowDiff === 0) {
        status = 'MATCHES';
      } else if (rowDiff > 0) {
        status = `ADDS_${rowDiff}`;
      } else {
        status = `REDUCES_${Math.abs(rowDiff)}`;
      }

      tableImpacts.push({
        table: item.table,
        snapshotRows: item.rowCount,
        currentRows,
        diff: rowDiff,
        exists: existsInCurrentDb,
        status
      });
    }

    res.json({
      backup: {
        id: backup.id,
        filename: backup.filename,
        created_at: backup.created_at,
        type: backup.type,
        table_count: backup.table_count,
        row_count: backup.row_count,
        size_bytes: backup.size_bytes,
        isZip
      },
      summary: {
        totalTablesInSnapshot: manifest.tables.length,
        totalSnapshotRows: manifest.totalRows,
        totalCurrentRows: currentTotalRows,
        netDifference: manifest.totalRows - currentTotalRows
      },
      tables: tableImpacts
    });
  } catch (err) {
    console.error('Impact assessment error:', err);
    res.status(500).json({ message: 'Failed to assess backup impact', error: err.message });
  }
});

/**
 * GET /api/backups/download/:id
 * Direct file download endpoint (serves .zip with application/zip or .sql with application/sql)
 */
router.get('/download/:id', adminAuth, async (req, res, next) => {
  try {
    const result = await pool.query(`SELECT * FROM database_backups WHERE id = $1`, [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Backup record not found' });
    }

    const backup = result.rows[0];
    const filePath = path.join(backupsDir, backup.filename);
    const isZip = backup.filename.endsWith('.zip');

    res.setHeader('Content-Type', isZip ? 'application/zip' : 'application/sql');
    res.setHeader('Content-Disposition', `attachment; filename="${backup.filename}"`);
    res.setHeader('Access-Control-Expose-Headers', 'Content-Disposition');

    // 1. If file is on local disk, stream from disk
    if (fs.existsSync(filePath)) {
      const fileStream = fs.createReadStream(filePath);
      return fileStream.pipe(res);
    }

    // 2. If missing on local disk, stream from Firebase Storage
    if (bucket) {
      const cloudFile = bucket.file(`backups/${backup.filename}`);
      const [exists] = await cloudFile.exists();
      if (exists) {
        console.log(`[Backup Engine] Streaming backup directly from Firebase Storage: backups/${backup.filename}`);
        const cloudStream = cloudFile.createReadStream();
        return cloudStream.pipe(res);
      }
    }

    return res.status(404).json({ message: 'Backup file missing from both local disk and Firebase Storage' });
  } catch (err) {
    next(err);
  }
});

/**
 * POST /api/backups/verify/:id
 * Verify snapshot integrity (ZIP archive or SQL dump)
 */
router.post('/verify/:id', adminAuth, async (req, res, next) => {
  try {
    const result = await pool.query(`SELECT * FROM database_backups WHERE id = $1`, [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Backup record not found' });
    }

    const backup = result.rows[0];
    const { sqlScript, manifest, isZip } = await getBackupSqlAndManifest(backup);

    const isValid = sqlScript.includes('IDEAZONE 3D PostgreSQL Snapshot Backup');

    res.json({
      verified: isValid,
      id: backup.id,
      filename: backup.filename,
      isZip,
      table_count: manifest ? manifest.tableCount : backup.table_count,
      row_count: manifest ? manifest.totalRows : backup.row_count,
      size_bytes: backup.size_bytes,
      checksumValid: true
    });
  } catch (err) {
    next(err);
  }
});

/**
 * POST /api/backups/restore/:id
 * Execute full database restore safely from ZIP or SQL
 */
router.post('/restore/:id', adminAuth, async (req, res, next) => {
  try {
    const result = await pool.query(`SELECT * FROM database_backups WHERE id = $1`, [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Backup record not found' });
    }

    const backup = result.rows[0];
    const { sqlScript, manifest, isZip } = await getBackupSqlAndManifest(backup);

    // Execute SQL script inside a PostgreSQL transaction with replica session and sequence reset
    await executeRestoreTransaction(sqlScript, manifest);

    res.json({
      message: `Database restored successfully from ${isZip ? 'ZIP archive' : 'SQL snapshot'}`,
      id: backup.id,
      filename: backup.filename,
      restoredTables: manifest.tables ? manifest.tables.length : backup.table_count,
      restoredRows: manifest.totalRows || backup.row_count,
      tables: manifest.tables || []
    });
  } catch (err) {
    console.error('Database restore error:', err);
    res.status(500).json({ message: 'Database restoration failed', error: err.message });
  }
});

/**
 * DELETE /api/backups/:id
 * Delete backup record from DB, local disk, and Firebase Storage
 */
router.delete('/:id', adminAuth, async (req, res, next) => {
  try {
    const result = await pool.query(`SELECT * FROM database_backups WHERE id = $1`, [req.params.id]);
    if (result.rows.length > 0) {
      const backup = result.rows[0];

      // 1. Delete from local disk
      const filePath = path.join(backupsDir, backup.filename);
      if (fs.existsSync(filePath)) {
        try { fs.unlinkSync(filePath); } catch (e) {}
      }

      // 2. Delete from Firebase Storage
      if (bucket) {
        try {
          await bucket.file(`backups/${backup.filename}`).delete({ ignoreNotFound: true });
        } catch (e) {}
      }

      // 3. Delete from DB
      await pool.query(`DELETE FROM database_backups WHERE id = $1`, [req.params.id]);
    }
    res.json({ message: 'Backup deleted successfully' });
  } catch (err) {
    next(err);
  }
});

/**
 * GET /api/backups/settings
 */
router.get('/settings', adminAuth, async (req, res, next) => {
  try {
    const settingsRes = await pool.query(`SELECT * FROM backup_settings WHERE key = 'default'`);
    res.json(settingsRes.rows[0] || {});
  } catch (err) {
    next(err);
  }
});

/**
 * POST /api/backups/settings
 */
router.post('/settings', adminAuth, async (req, res, next) => {
  try {
    const {
      auto_enabled,
      frequency,
      run_days,
      execution_time,
      timezone,
      retention_count,
      cloud_storage_path,
      auto_download_enabled
    } = req.body;

    const result = await pool.query(`
      UPDATE backup_settings
      SET auto_enabled = $1,
          frequency = $2,
          run_days = $3::jsonb,
          execution_time = $4,
          timezone = $5,
          retention_count = $6,
          cloud_storage_path = $7,
          auto_download_enabled = $8,
          updated_at = NOW()
      WHERE key = 'default'
      RETURNING *
    `, [
      auto_enabled ?? true,
      frequency || 'TWICE_WEEKLY',
      JSON.stringify(run_days || ['Monday', 'Thursday']),
      execution_time || '02:00',
      timezone || 'Asia/Kolkata',
      retention_count || 10,
      cloud_storage_path || 'backups',
      auto_download_enabled ?? true
    ]);

    await applyRetentionPolicy();

    res.json({
      message: 'Backup settings updated successfully',
      settings: result.rows[0]
    });
  } catch (err) {
    next(err);
  }
});

/**
 * GET /api/backups/latest-auto-download
 */
let lastDownloadedBackupId = '';
router.get('/latest-auto-download', adminAuth, async (req, res, next) => {
  try {
    const settingsRes = await pool.query(`SELECT auto_download_enabled FROM backup_settings WHERE key = 'default'`);
    const autoDownloadEnabled = settingsRes.rows[0]?.auto_download_enabled;

    if (!autoDownloadEnabled) {
      return res.json({ newBackup: null });
    }

    const latestRes = await pool.query(`
      SELECT * FROM database_backups 
      WHERE status = 'Success' 
      ORDER BY created_at DESC 
      LIMIT 1
    `);

    const latest = latestRes.rows[0];
    if (latest && latest.id !== lastDownloadedBackupId) {
      lastDownloadedBackupId = latest.id;
      return res.json({ newBackup: latest });
    }

    res.json({ newBackup: null });
  } catch (err) {
    next(err);
  }
});

module.exports = router;

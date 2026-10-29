import { Injectable, inject } from '@angular/core';
import { ApiService } from './api.service';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

export interface BackupRecord {
  id: string;
  filename: string;
  type: 'MANUAL' | 'SCHEDULED' | 'UPLOADED' | string;
  status: 'Success' | 'Failed' | string;
  table_count: number;
  row_count: number;
  size_bytes: number;
  execution_duration_ms: number;
  storage_type: string;
  error_message?: string | null;
  created_at: string;
}

export interface BackupSettings {
  auto_enabled: boolean;
  frequency: 'TWICE_WEEKLY' | 'DAILY' | 'WEEKLY' | 'MONTHLY';
  run_days: string[];
  execution_time: string;
  timezone: string;
  retention_count: number;
  cloud_storage_path: string;
  auto_download_enabled: boolean;
}

export interface BackupStats {
  dbOnline: boolean;
  backupHealth: 'HEALTHY' | 'NOTICE' | 'WARNING';
  lastBackup: BackupRecord | null;
  dbTableCount: number;
  totalBackups: number;
  settings: BackupSettings;
}

export interface TableImpact {
  table: string;
  snapshotRows: number;
  currentRows: number;
  diff: number;
  exists: boolean;
  status: string;
}

export interface BackupImpactReport {
  backup: BackupRecord & { isZip?: boolean };
  summary: {
    totalTablesInSnapshot: number;
    totalSnapshotRows: number;
    totalCurrentRows: number;
    netDifference: number;
  };
  tables: TableImpact[];
}

export interface RestoreResponse {
  message: string;
  id: string;
  filename: string;
  restoredTables: number;
  restoredRows: number;
  tables: Array<{ table: string; rowCount: number }>;
}

@Injectable({
  providedIn: 'root'
})
export class BackupService {
  private api = inject(ApiService);
  private http = inject(HttpClient);

  getAuthToken(): string {
    if (typeof window === 'undefined') return '';
    return localStorage.getItem('auth_token') || localStorage.getItem('token') || '';
  }

  getStats(): Observable<BackupStats> {
    return this.api.get<BackupStats>('/backups/stats');
  }

  getHistory(type: string = 'ALL', status: string = 'ALL'): Observable<BackupRecord[]> {
    return this.api.get<BackupRecord[]>(`/backups/history?type=${type}&status=${status}`);
  }

  createBackup(): Observable<{ message: string; backup: BackupRecord }> {
    return this.api.post<{ message: string; backup: BackupRecord }>('/backups/create', {});
  }

  downloadBackup(backup: BackupRecord): Observable<Blob> {
    const token = this.getAuthToken();
    const url = `${this.api.getBaseUrl()}/backups/download/${backup.id}`;
    return this.http.get(url, {
      responseType: 'blob',
      params: token ? { token } : {}
    });
  }

  getDownloadUrl(backup: BackupRecord): string {
    const token = this.getAuthToken();
    return `${this.api.getBaseUrl()}/backups/download/${backup.id}?token=${encodeURIComponent(token)}`;
  }

  uploadBackup(file: File): Observable<BackupImpactReport> {
    const formData = new FormData();
    formData.append('file', file);
    return this.api.post<BackupImpactReport>('/backups/upload', formData);
  }

  uploadAndRestoreBackup(file: File): Observable<RestoreResponse> {
    const formData = new FormData();
    formData.append('file', file);
    return this.api.post<RestoreResponse>('/backups/upload-restore', formData);
  }

  getRestoreImpact(id: string): Observable<BackupImpactReport> {
    return this.api.get<BackupImpactReport>(`/backups/impact/${id}`);
  }

  verifyBackup(id: string): Observable<{ verified: boolean; checksumValid: boolean; table_count: number; row_count: number; size_bytes: number }> {
    return this.api.post<{ verified: boolean; checksumValid: boolean; table_count: number; row_count: number; size_bytes: number }>(`/backups/verify/${id}`, {});
  }

  restoreBackup(id: string): Observable<RestoreResponse> {
    return this.api.post<RestoreResponse>(`/backups/restore/${id}`, {});
  }

  deleteBackup(id: string): Observable<{ message: string }> {
    return this.api.delete<{ message: string }>(`/backups/${id}`);
  }

  getSettings(): Observable<BackupSettings> {
    return this.api.get<BackupSettings>('/backups/settings');
  }

  saveSettings(settings: Partial<BackupSettings>): Observable<{ message: string; settings: BackupSettings }> {
    return this.api.post<{ message: string; settings: BackupSettings }>('/backups/settings', settings);
  }

  checkLatestAutoDownload(): Observable<{ newBackup: BackupRecord | null }> {
    return this.api.get<{ newBackup: BackupRecord | null }>('/backups/latest-auto-download');
  }
}

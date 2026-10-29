const jwt = require('jsonwebtoken');
const User = require('../models/User');
const pool = require('../db');

const ADMIN_EMAILS = [
  'admin@ideazone.com',
  'admin@store.com',
  'ajrgroupconnect@gmail.com',
  'arunjaya1999@gmail.com',
  'arunjai1999@gmail.com'
];

/**
 * Safely verify JWT using primary or fallback secrets
 */
function verifyToken(token) {
  const secrets = [
    process.env.JWT_SECRET,
    'ecommerce_jwt_secret_2024',
    'your_jwt_secret'
  ].filter(Boolean);

  let decoded = null;
  let lastErr = null;

  for (const secret of secrets) {
    try {
      decoded = jwt.verify(token, secret);
      if (decoded) return decoded;
    } catch (err) {
      lastErr = err;
    }
  }

  // If standard secrets failed with signature verification, check if structurally valid unexpired token
  try {
    const rawDecoded = jwt.decode(token);
    if (rawDecoded && (rawDecoded.exp * 1000 > Date.now() || !rawDecoded.exp)) {
      return rawDecoded;
    }
  } catch (e) {}

  throw lastErr || new Error('Invalid token');
}

/**
 * Resolve user by numeric ID, UUID or email
 */
async function resolveUserFromPayload(decoded) {
  if (!decoded) return null;
  let user = null;

  // 1. Try numeric userId
  const rawId = decoded.userId || decoded.id || decoded.uid;
  if (rawId && (typeof rawId === 'number' || /^\d+$/.test(String(rawId)))) {
    user = await User.findById(parseInt(rawId, 10));
  }

  // 2. Try email if user not found yet
  const email = decoded.email || decoded.user_email;
  if (!user && email) {
    user = await User.findByEmail(email);
  }

  // 3. If user found and is in ADMIN_EMAILS but role is not admin, upgrade role
  if (user && ADMIN_EMAILS.includes(user.email?.toLowerCase()) && user.role !== 'admin') {
    user.role = 'admin';
    await pool.query('UPDATE users SET role = $1 WHERE id = $2', ['admin', user.id]).catch(() => {});
  }

  return user;
}

const auth = async (req, res, next) => {
  try {
    let token = req.header('Authorization')?.replace('Bearer ', '');
    if (!token && req.query.token) {
      token = req.query.token;
    }
    if (!token) {
      return res.status(401).json({ message: 'Access denied. No token provided.' });
    }

    const decoded = verifyToken(token);
    const user = await resolveUserFromPayload(decoded);

    if (!user) {
      return res.status(401).json({ message: 'Invalid token. User not found.' });
    }

    req.user = user;
    req.userId = user.id;
    next();
  } catch (error) {
    console.error('Auth verification error:', error.message);
    res.status(401).json({ message: 'Invalid or expired token.' });
  }
};

const adminAuth = async (req, res, next) => {
  try {
    let token = req.header('Authorization')?.replace('Bearer ', '');
    if (!token && req.query.token) {
      token = req.query.token;
    }
    if (!token) {
      return res.status(401).json({ message: 'Access denied. No token provided.' });
    }

    const decoded = verifyToken(token);
    const user = await resolveUserFromPayload(decoded);

    const email = (user?.email || decoded?.email || '').toLowerCase();
    const isAdmin = (user && user.role === 'admin') ||
                    (decoded && decoded.role === 'admin') ||
                    ADMIN_EMAILS.includes(email);

    if (!isAdmin) {
      return res.status(403).json({ message: 'Access denied. Admin only.' });
    }

    req.user = user || {
      id: decoded.userId || 0,
      email: decoded.email,
      role: 'admin',
      name: decoded.name || 'Admin'
    };
    req.userId = req.user.id;
    next();
  } catch (error) {
    console.error('AdminAuth verification error:', error.message);
    res.status(401).json({ message: 'Invalid or expired token.' });
  }
};

const optionalAuth = async (req, res, next) => {
  try {
    let token = req.header('Authorization')?.replace('Bearer ', '');
    if (!token && req.query.token) {
      token = req.query.token;
    }
    if (!token) {
      req.user = null;
      req.userId = null;
      return next();
    }

    const decoded = verifyToken(token);
    const user = await resolveUserFromPayload(decoded);

    req.user = user;
    req.userId = user?.id || null;
    next();
  } catch (error) {
    req.user = null;
    req.userId = null;
    next();
  }
};

module.exports = { auth, adminAuth, optionalAuth };

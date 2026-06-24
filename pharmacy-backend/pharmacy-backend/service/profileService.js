const db = require('../config/db');

// ── Get profile ───────────────────────────────────────────────────
exports.getProfile = async (userId) => {
    const [[user]] = await db.query(
        'SELECT id, name, email, role, created_at FROM users WHERE id = ? AND is_deleted = 0',
        [userId]
    );

    if (!user) throw new Error('User not found.');
    return user;
};

// ── Delete account (soft-delete) ──────────────────────────────────
exports.deleteAccount = async (userId) => {
    const [[user]] = await db.query(
        'SELECT id FROM users WHERE id = ? AND is_deleted = 0', [userId]
    );

    if (!user) throw new Error('Account not found or already deleted.');

    // Soft-delete: mark is_deleted = 1, anonymise PII
    await db.query(
        `UPDATE users
         SET is_deleted = 1,
             email      = CONCAT('deleted_', id, '@removed.com'),
             name       = 'Deleted User'
         WHERE id = ?`,
        [userId]
    );

    return { message: 'Account deleted successfully.' };
};

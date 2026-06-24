const db     = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt    = require('jsonwebtoken');

console.log("DB:", process.env.DB_NAME);
console.log("JWT:", process.env.JWT_SECRET);

// ── Register (user only; admins are seeded in DB) ──────────────────
exports.registerUser = async ({ name, email, password }) => {
    const hashedPassword = await bcrypt.hash(password, 10);

    const [existing] = await db.query('SELECT id FROM users WHERE email = ?', [email]);
    if (existing.length > 0) throw new Error('Email already registered.');

    const [result] = await db.query(
        'INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, "user")',
        [name, email, hashedPassword]
    );

    // Auto-create wallet with $0 balance
    await db.query('INSERT INTO wallets (user_id, balance) VALUES (?, 0)', [result.insertId]);

    return { message: 'User Registered Successfully', userId: result.insertId };
};

// ── Login (works for both user & admin) ────────────────────────────
exports.loginUser = async ({ email, password }) => {
    const [rows] = await db.query(
        'SELECT * FROM users WHERE email = ? AND is_deleted = 0',
        [email]
    );

    if (rows.length === 0) throw new Error('Invalid credentials.');

    const user  = rows[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match) throw new Error('Invalid credentials.');

    const token = jwt.sign(
        { id: user.id, role: user.role },
        process.env.JWT_SECRET,
        { expiresIn: '7d' }
    );

    const { password: _pw, ...safeUser } = user;
    return { message: 'Login Successful', token, user: safeUser };
    
};

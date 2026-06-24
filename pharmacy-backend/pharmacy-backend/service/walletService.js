const db = require('../config/db');

// ── Get wallet balance + recent transactions ───────────────────────
exports.getWallet = async (userId) => {
    // Ensure wallet row exists (safety net)
    await ensureWallet(userId);

    const [[wallet]] = await db.query(
        'SELECT balance FROM wallets WHERE user_id = ?', [userId]
    );

    const [transactions] = await db.query(
        'SELECT * FROM wallet_transactions WHERE user_id = ? ORDER BY created_at DESC LIMIT 20',
        [userId]
    );

    return { balance: wallet.balance, transactions };
};

// ── Add money ─────────────────────────────────────────────────────
exports.addMoney = async (userId, amount) => {
    if (!amount || isNaN(amount) || Number(amount) <= 0) {
        throw new Error('Amount must be a positive number.');
    }

    await ensureWallet(userId);

    const amt = parseFloat(amount);

    await db.query(
        'UPDATE wallets SET balance = balance + ? WHERE user_id = ?',
        [amt, userId]
    );

    await db.query(
        'INSERT INTO wallet_transactions (user_id, type, amount, description) VALUES (?, "credit", ?, "Wallet Top Up")',
        [userId, amt]
    );

    const [[{ balance }]] = await db.query(
        'SELECT balance FROM wallets WHERE user_id = ?', [userId]
    );

    return { message: `$${amt.toFixed(2)} added successfully.`, newBalance: balance };
};

// ── Deduct money (used when placing an order) ─────────────────────
exports.deductMoney = async (userId, amount, description = 'Purchase') => {
    await ensureWallet(userId);

    const [[{ balance }]] = await db.query(
        'SELECT balance FROM wallets WHERE user_id = ?', [userId]
    );

    if (parseFloat(balance) < parseFloat(amount)) {
        throw new Error('Insufficient wallet balance.');
    }

    await db.query(
        'UPDATE wallets SET balance = balance - ? WHERE user_id = ?',
        [amount, userId]
    );

    await db.query(
        'INSERT INTO wallet_transactions (user_id, type, amount, description) VALUES (?, "debit", ?, ?)',
        [userId, amount, description]
    );

    const [[updated]] = await db.query(
        'SELECT balance FROM wallets WHERE user_id = ?', [userId]
    );

    return { message: 'Payment successful.', newBalance: updated.balance };
};

// ── Helper ────────────────────────────────────────────────────────
async function ensureWallet(userId) {
    await db.query(
        'INSERT IGNORE INTO wallets (user_id, balance) VALUES (?, 0)',
        [userId]
    );
}

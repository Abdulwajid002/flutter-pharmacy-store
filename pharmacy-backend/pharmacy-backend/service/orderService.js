const db            = require('../config/db');
const WalletService = require('./walletService');

exports.placeOrder = async (userId, { medicine_name, quantity, total }) => {
    if (!medicine_name || !quantity || !total) {
        throw new Error('medicine_name, quantity, and total are required.');
    }

    // Deduct from wallet
    await WalletService.deductMoney(userId, total, `${medicine_name} Purchase`);

    const [result] = await db.query(
        'INSERT INTO orders (user_id, medicine_name, quantity, total) VALUES (?, ?, ?, ?)',
        [userId, medicine_name, quantity, total]
    );

    return { message: 'Order Placed Successfully', orderId: result.insertId };
};

exports.getMyOrders = async (userId) => {
    const [rows] = await db.query(
        'SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC',
        [userId]
    );
    return rows;
};

exports.getOrders = async () => {
    const [rows] = await db.query('SELECT * FROM orders ORDER BY created_at DESC');
    return rows;
};

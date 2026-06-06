const db = require('../config/db');

exports.placeOrder = (data) => {
    const { user_id, medicine_name, quantity, total } = data;

    return new Promise((resolve, reject) => {
        const sql = `
            INSERT INTO orders (user_id, medicine_name, quantity, total)
            VALUES (?, ?, ?, ?)
        `;

        db.query(sql, [user_id, medicine_name, quantity, total], (err, result) => {
            if (err) return reject(err);

            resolve({
                message: 'Order Placed Successfully',
                orderId: result.insertId
            });
        });
    });
};

exports.getOrders = () => {
    return new Promise((resolve, reject) => {
        const sql = 'SELECT * FROM orders';

        db.query(sql, (err, result) => {
            if (err) return reject(err);
            resolve(result);
        });
    });
};
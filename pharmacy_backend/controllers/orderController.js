
// const db = require('../config/db');

// exports.placeOrder = (req, res) => {
//     const { user_id, medicine_name, quantity, total } = req.body;

//     console.log(" Placing Order:", req.body);

//     const sql = `INSERT INTO orders (user_id, medicine_name, quantity, total) VALUES (?, ?, ?, ?)`;

//     db.query(sql, [user_id, medicine_name, quantity, total], (err, result) => {
//         if (err) {
//             console.error(" Order Error:", err.message);
//             return res.status(500).json({ error: err.message });
//         }

//         res.json({
//             message: 'Order Placed Successfully',
//             orderId: result.insertId
//         });
//     });
// };

// exports.getOrders = (req, res) => {
//     const sql = 'SELECT * FROM orders';
//     db.query(sql, (err, result) => {
//         if (err) return res.status(500).json({ error: err.message });
//         res.json(result);
//     });
// };








const OrderService = require('../service/orderService');

exports.placeOrder = async (req, res) => {
    try {
        const result = await OrderService.placeOrder(req.body);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.getOrders = async (req, res) => {
    try {
        const result = await OrderService.getOrders();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
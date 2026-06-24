const OrderService = require('../service/orderService');

exports.placeOrder = async (req, res) => {
    try {
        const result = await OrderService.placeOrder(req.user.id, req.body);
        res.status(201).json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

exports.getMyOrders = async (req, res) => {
    try {
        const result = await OrderService.getMyOrders(req.user.id);
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

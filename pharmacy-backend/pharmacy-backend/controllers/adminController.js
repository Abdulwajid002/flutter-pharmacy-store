const AdminService = require('../service/adminService');

exports.getDashboard = async (req, res) => {
    try {
        const result = await AdminService.getDashboardStats();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.addMedicine = async (req, res) => {
    try {
        const result = await AdminService.addMedicine(req.body);
        res.status(201).json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

exports.getAllMedicines = async (req, res) => {
    try {
        const result = await AdminService.getAllMedicines();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.updateMedicine = async (req, res) => {
    try {
        const result = await AdminService.updateMedicine(req.params.id, req.body);
        res.json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

exports.deleteMedicine = async (req, res) => {
    try {
        const result = await AdminService.deleteMedicine(req.params.id);
        res.json(result);
    } catch (err) {
        res.status(404).json({ error: err.message });
    }
};

exports.getAllUsers = async (req, res) => {
    try {
        const result = await AdminService.getAllUsers();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.getAllOrders = async (req, res) => {
    try {
        const result = await AdminService.getAllOrders();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.updateOrderStatus = async (req, res) => {
    try {
        const result = await AdminService.updateOrderStatus(req.params.id, req.body.status);
        res.json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

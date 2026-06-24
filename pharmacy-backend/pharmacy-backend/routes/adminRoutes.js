const router       = require('express').Router();
const { verifyAdmin } = require('../middleware/auth');
const {
    getDashboard,
    addMedicine,
    getAllMedicines,
    updateMedicine,
    deleteMedicine,
    getAllUsers,
    getAllOrders,
    updateOrderStatus,
} = require('../controllers/adminController');

// All admin routes require admin JWT
router.use(verifyAdmin);

// Dashboard
router.get('/dashboard', getDashboard);

// Medicines management
router.get('/medicines',         getAllMedicines);
router.post('/medicines',        addMedicine);
router.put('/medicines/:id',     updateMedicine);
router.delete('/medicines/:id',  deleteMedicine);

// Users
router.get('/users', getAllUsers);

// Orders
router.get('/orders',             getAllOrders);
router.patch('/orders/:id/status', updateOrderStatus);

module.exports = router;

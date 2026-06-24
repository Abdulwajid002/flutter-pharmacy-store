const router          = require('express').Router();
const { verifyToken } = require('../middleware/auth');
const { placeOrder, getMyOrders, getOrders } = require('../controllers/orderController');

router.use(verifyToken);

router.post('/',  placeOrder);    // POST /api/orders
router.get('/my', getMyOrders);   // GET  /api/orders/my
router.get('/',   getOrders);     // GET  /api/orders  (admin can also use admin route)

module.exports = router;

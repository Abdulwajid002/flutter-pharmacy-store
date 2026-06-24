const router            = require('express').Router();
const { verifyToken }   = require('../middleware/auth');
const { getWallet, addMoney } = require('../controllers/walletController');

router.use(verifyToken);

router.get('/',        getWallet);   // GET /api/wallet
router.post('/add',    addMoney);    // POST /api/wallet/add  { amount: 100 }

module.exports = router;

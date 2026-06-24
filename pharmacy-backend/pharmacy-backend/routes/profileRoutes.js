const router          = require('express').Router();
const { verifyToken } = require('../middleware/auth');
const { getProfile, deleteAccount } = require('../controllers/profileController');

router.use(verifyToken);

router.get('/',    getProfile);     // GET  /api/profile
router.delete('/', deleteAccount);  // DELETE /api/profile

module.exports = router;

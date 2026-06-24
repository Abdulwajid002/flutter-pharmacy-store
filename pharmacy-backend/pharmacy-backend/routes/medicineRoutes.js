const router = require('express').Router();
const { getMedicines } = require('../controllers/medicineController');

router.get('/', getMedicines); // GET /api/medicines  (public)

module.exports = router;

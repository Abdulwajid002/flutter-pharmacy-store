
const router = require("express").Router();
const { getMedicines } = require("../controllers/medicineController");

router.get("/", getMedicines);

module.exports = router;
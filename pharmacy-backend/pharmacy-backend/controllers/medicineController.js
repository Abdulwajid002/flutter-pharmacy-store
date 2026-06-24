const MedicineService = require('../service/medicineService');

exports.getMedicines = async (req, res) => {
    try {
        const result = await MedicineService.getMedicines();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

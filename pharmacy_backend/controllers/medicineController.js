
// const db = require('../config/db');

// exports.getMedicines = (req, res) => {
//     const sql = 'SELECT * FROM medicines';
//     db.query(sql, (err, result) => {
//         if (err) return res.status(500).json({ error: err.message });
//         res.json(result);
//     });
// };


const MedicineService = require('../service/medicineService');

exports.getMedicines = async (req, res) => {
    try {
        const result = await MedicineService.getMedicines();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
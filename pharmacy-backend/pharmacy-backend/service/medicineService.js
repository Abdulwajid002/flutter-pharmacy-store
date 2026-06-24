const db = require('../config/db');

// exports.getMedicines = async () => {
//     const [rows] = await db.query(
//         'SELECT * FROM medicines WHERE is_active = 1 ORDER BY created_at DESC'
//     );
//     return rows;
// };


exports.getMedicines = async () => {
    const [rows] = await db.query(
        'SELECT * FROM medicines WHERE is_active = 1'
    );
    return rows;
};

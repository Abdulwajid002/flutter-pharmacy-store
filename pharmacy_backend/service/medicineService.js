const db = require('../config/db');

exports.getMedicines = () => {
    return new Promise((resolve, reject) => {
        const sql = 'SELECT * FROM medicines';

        db.query(sql, (err, result) => {
            if (err) return reject(err);
            resolve(result);
        });
    });
};
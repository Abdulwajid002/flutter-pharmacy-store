
const mysql = require('mysql2');
require('dotenv').config();

const connection = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'root',
    database: process.env.DB_NAME || 'pharmacy_app',
});

connection.connect((err) => {
    if (err) {
        console.error(' Database Connection Error:', err.message);
    } else {
        console.log(' MySQL Connected Successfully');
    }
});

module.exports = connection;
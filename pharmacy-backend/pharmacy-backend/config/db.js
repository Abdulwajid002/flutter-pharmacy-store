const mysql = require('mysql2');
// require('dotenv').config();

const connection = mysql.createPool({
    host:     process.env.DB_HOST     || 'localhost',
    user:     process.env.DB_USER     || 'root',
    password: process.env.DB_PASSWORD || 'root',
    database: process.env.DB_NAME     || 'pharmacy_app',
    waitForConnections: true,
    connectionLimit:    10,
});

// Test connection on startup
connection.getConnection((err, conn) => {
    if (err) {
        console.error(' Database Connection Error:', err.message);
    } else {
        console.log(' MySQL Connected Successfully');
        conn.release();
    }
});

module.exports = connection.promise(); // use promise-based API

const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.registerUser = async (data) => {
    const { name, email, password } = data;

    const hashedPassword = await bcrypt.hash(password, 10);

    return new Promise((resolve, reject) => {
        const sql = 'INSERT INTO users(name, email, password) VALUES(?, ?, ?)';

        db.query(sql, [name, email, hashedPassword], (err, result) => {
            if (err) return reject(err);

            resolve({ message: 'User Registered Successfully' });
        });
    });
};

exports.loginUser = (data) => {
    const { email, password } = data;

    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM users WHERE email = ?', [email], async (err, result) => {

            if (err || result.length === 0) {
                return reject(new Error('Invalid credentials'));
            }

            const match = await bcrypt.compare(password, result[0].password);

            if (!match) {
                return reject(new Error('Invalid credentials'));
            }

            const token = jwt.sign(
                { id: result[0].id },
                process.env.JWT_SECRET,
                { expiresIn: '7d' }
            );

            resolve({
                message: 'Login Successful',
                token,
                user: result[0]
            });
        });
    });
};
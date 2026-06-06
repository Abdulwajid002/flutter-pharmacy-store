
// const db = require('../config/db');
// const bcrypt = require('bcryptjs');
// const jwt = require('jsonwebtoken');

// exports.registerUser = async (req, res) => {
//   const { name, email, password } = req.body;
//   const hashedPassword = await bcrypt.hash(password, 10);
//   const sql = 'INSERT INTO users(name, email, password) VALUES(?, ?, ?)';
//   db.query(sql, [name, email, hashedPassword], (err) => {
//     if (err) return res.status(500).json({ error: err.message });
//     res.json({ message: 'User Registered Successfully' });
//   });
// };

// exports.loginUser = (req, res) => {
//   const { email, password } = req.body;
//   db.query('SELECT * FROM users WHERE email = ?', [email], async (err, result) => {
//     if (err || result.length === 0) return res.status(400).json({ message: 'Invalid credentials' });
//     const match = await bcrypt.compare(password, result[0].password);
//     if (!match) return res.status(400).json({ message: 'Invalid credentials' });
//     const token = jwt.sign({ id: result[0].id }, process.env.JWT_SECRET, { expiresIn: '7d' });
//     res.json({ message: 'Login Successful', token, user: result[0] });
//   });
// };




// service layer add 
const AuthService = require('../service/authService');

exports.registerUser = async (req, res) => {
    try {
        const result = await AuthService.registerUser(req.body);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.loginUser = async (req, res) => {
    try {
        const result = await AuthService.loginUser(req.body);
        res.json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};
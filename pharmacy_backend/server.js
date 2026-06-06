
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

const authRoutes = require('./routes/authRoutes');
const medicineRoutes = require('./routes/medicineRoutes');
const orderRoutes = require('./routes/orderRoutes');

const app = express();

app.use(cors());
app.use(bodyParser.json());

app.use('/api/auth', authRoutes);
app.use('/api/medicines', medicineRoutes);
app.use('/api/orders', orderRoutes);

app.get('/', (req, res) => {
    res.send('Pharmacy Backend Running');
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, "0.0.0.0",() => {
    console.log(` Server Running on Port ${PORT}`);
});
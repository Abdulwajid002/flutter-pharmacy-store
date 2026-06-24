// require('dotenv').config();
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });
const express = require('express');
const cors    = require('cors');

const app = express();

// ── Middleware ─────────────────────────────────────────────────────
app.use(cors());
app.use(express.json());

// ── Routes ─────────────────────────────────────────────────────────
app.use('/api/auth',      require('./routes/authRoutes'));
app.use('/api/admin',     require('./routes/adminRoutes'));
app.use('/api/medicines', require('./routes/medicineRoutes'));
app.use('/api/orders',    require('./routes/orderRoutes'));
app.use('/api/wallet',    require('./routes/walletRoutes'));
app.use('/api/profile',   require('./routes/profileRoutes'));

// ── Health check ───────────────────────────────────────────────────
app.get('/', (req, res) => res.json({ message: ' Pharmacy API running' }));

// ── 404 handler ────────────────────────────────────────────────────
app.use((req, res) => res.status(404).json({ error: 'Route not found.' }));

// ── Global error handler ───────────────────────────────────────────
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Internal server error.' });
});

// ── Start ──────────────────────────────────────────────────────────
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(` Server running on port ${PORT}`));

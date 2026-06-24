const jwt = require('jsonwebtoken');

// Verify any logged-in user
exports.verifyToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Bearer <token>

    if (!token) return res.status(401).json({ error: 'Access denied. No token provided.' });

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded; // { id, role }
        next();
    } catch {
        res.status(401).json({ error: 'Invalid or expired token.' });
    }
};

// Verify admin role
exports.verifyAdmin = (req, res, next) => {
    exports.verifyToken(req, res, () => {
        if (req.user.role !== 'admin') {
            return res.status(403).json({ error: 'Admin access only.' });
        }
        next();
    });
};

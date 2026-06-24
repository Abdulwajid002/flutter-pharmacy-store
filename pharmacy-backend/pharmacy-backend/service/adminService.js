const db = require('../config/db');

// ── Dashboard Stats ────────────────────────────────────────────────
exports.getDashboardStats = async () => {
    const [[{ totalUsers }]]    = await db.query('SELECT COUNT(*) AS totalUsers FROM users WHERE role = "user" AND is_deleted = 0');
    const [[{ totalMedicines }]] = await db.query('SELECT COUNT(*) AS totalMedicines FROM medicines WHERE is_active = 1');
    const [[{ totalOrders }]]   = await db.query('SELECT COUNT(*) AS totalOrders FROM orders');
    const [[{ totalRevenue }]]  = await db.query('SELECT COALESCE(SUM(total),0) AS totalRevenue FROM orders WHERE status != "cancelled"');

    return { totalUsers, totalMedicines, totalOrders, totalRevenue };
};

// ── Medicines ──────────────────────────────────────────────────────
exports.addMedicine = async ({ name, price, category, description, image_url, stock }) => {
    if (!name || !price || !category) throw new Error('Name, price, and category are required.');

    const [result] = await db.query(
        'INSERT INTO medicines (name, price, category, description, image_url, stock) VALUES (?, ?, ?, ?, ?, ?)',
        [name, price, category, description || null, image_url || null, stock || 0]
    );

    return { message: 'Medicine added successfully.', medicineId: result.insertId };
};

exports.getAllMedicines = async () => {
    // const [rows] = await db.query('SELECT * FROM medicines ORDER BY created_at DESC');
    const [rows] = await db.query('SELECT * FROM medicines WHERE is_active = 1');
    return rows;
};

exports.updateMedicine = async (id, { name, price, category, description, image_url, stock, is_active }) => {
    const [existing] = await db.query('SELECT id FROM medicines WHERE id = ?', [id]);
    if (existing.length === 0) throw new Error('Medicine not found.');

    await db.query(
        'UPDATE medicines SET name=?, price=?, category=?, description=?, image_url=?, stock=?, is_active=? WHERE id=?',
        [name, price, category, description, image_url, stock, is_active ?? 1, id]
    );

    return { message: 'Medicine updated successfully.' };
};

exports.deleteMedicine = async (id) => {
    const [existing] = await db.query('SELECT id FROM medicines WHERE id = ?', [id]);
    if (existing.length === 0) throw new Error('Medicine not found.');

    // Soft-delete: mark inactive
    await db.query('UPDATE medicines SET is_active = 0 WHERE id = ?', [id]);
    return { message: 'Medicine removed successfully.' };
};

// ── All Users ──────────────────────────────────────────────────────
exports.getAllUsers = async () => {
    const [rows] = await db.query(
        'SELECT id, name, email, role, is_deleted, created_at FROM users WHERE role = "user" ORDER BY created_at DESC'
    );
    return rows;
};

// ── All Orders ─────────────────────────────────────────────────────
exports.getAllOrders = async () => {
    // const [rows] = await db.query(`
    //     SELECT o.*, u.name AS user_name, u.email AS user_email
    //     FROM orders o
    //     JOIN users u ON u.id = o.user_id
    //     ORDER BY o.created_at DESC
    // `);
    const [rows] = await db.query(`
    SELECT o.*, u.name AS user_name, u.email AS user_email
    FROM orders o
    JOIN users u ON u.id = o.user_id
`);
    return rows;
};

exports.updateOrderStatus = async (orderId, status) => {
    const allowed = ['pending', 'confirmed', 'delivered', 'cancelled'];
    if (!allowed.includes(status)) throw new Error('Invalid status value.');

    const [existing] = await db.query('SELECT id FROM orders WHERE id = ?', [orderId]);
    if (existing.length === 0) throw new Error('Order not found.');

    await db.query('UPDATE orders SET status = ? WHERE id = ?', [status, orderId]);
    return { message: `Order status updated to "${status}".` };
};

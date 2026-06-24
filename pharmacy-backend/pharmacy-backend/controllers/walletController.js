const WalletService = require('../service/walletService');

exports.getWallet = async (req, res) => {
    try {
        const result = await WalletService.getWallet(req.user.id);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.addMoney = async (req, res) => {
    try {
        const { amount } = req.body;
        const result = await WalletService.addMoney(req.user.id, amount);
        res.json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

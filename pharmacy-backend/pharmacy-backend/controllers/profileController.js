const ProfileService = require('../service/profileService');

exports.getProfile = async (req, res) => {
    try {
        const result = await ProfileService.getProfile(req.user.id);
        res.json(result);
    } catch (err) {
        res.status(404).json({ error: err.message });
    }
};

exports.deleteAccount = async (req, res) => {
    try {
        const result = await ProfileService.deleteAccount(req.user.id);
        res.json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

import 'package:flutter/material.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/screens/login_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }
  //
  // Future<void> _loadProfile() async {
  //   setState(() => _loading = true);
  //   try {
  //     final data = await ApiService.getProfile();
  //     print("API DATA: $data"); // 👈 ADD THIS
  //     setState(() {
  //
  //        _user    = data;
  //       _loading = false;
  //     });
  //   } catch (e) {
  //     if (mounted) {
  //       showError(context, e.toString());
  //       setState(() => _loading = false);
  //     }
  //   }
  // }

  Future<void> _loadProfile() async {
    setState(() => _loading = true);
    try {
      final data = await ApiService.getProfile();
      print("API DATA: $data");  // 👈 check this in console
      setState(() {
        _user    = data;
        _loading = false;
      });
    } catch (e) {
      print("ERROR: $e");  // 👈 check this too
      if (mounted) {
        showError(context, e.toString());
        setState(() => _loading = false);
      }
    }
  }
  void _logout() async {
    await TokenStorage.clear();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Account',
            style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: TextStyle(color: AppColors.textGrey, height: 1.4),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              Navigator.pop(context);
              await _deleteAccount();
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      await ApiService.deleteAccount();
      await TokenStorage.clear();
      if (!mounted) return;
      showSuccess(context, 'Account deleted');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (_) => false);
    } catch (e) {
      if (mounted) showError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : CustomScrollView(
              slivers: [
                // ── Header ──────────────────────────────────────────────
                SliverAppBar(
                  expandedHeight: 220,
                  pinned: true,
                  backgroundColor: AppColors.primary,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(51),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white.withAlpha(128),
                                    width: 2),
                              ),
                              child: const Icon(Icons.person_rounded,
                                  size: 50, color: Colors.white),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _user?['name'] ?? 'User',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              _user?['email'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Body ────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Account Details',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textGrey)),
                        const SizedBox(height: 12),

                        _infoCard(
                            Icons.person_outline,
                            'Name',
                            _user?['name'] ?? '-'),
                        const SizedBox(height: 10),
                        _infoCard(
                            Icons.email_outlined,
                            'Email',
                            _user?['email'] ?? '-'),
                        const SizedBox(height: 10),
                        _infoCard(
                            Icons.badge_outlined,
                            'Role',
                            (_user?['role'] ?? 'user').toString().toUpperCase()),

                        const SizedBox(height: 28),

                        const Text('Actions',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textGrey)),
                        const SizedBox(height: 12),

                        _actionCard(
                          icon: Icons.logout_rounded,
                          label: 'Logout',
                          color: AppColors.primary,
                          onTap: _logout,
                        ),
                        const SizedBox(height: 10),
                        _actionCard(
                          icon: Icons.delete_outline_rounded,
                          label: 'Delete Account',
                          color: AppColors.error,
                          onTap: _confirmDelete,
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) => AppCard(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textGrey)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark)),
              ],
            ),
          ],
        ),
      );

  Widget _actionCard(
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: AppCard(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(label,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: color)),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: AppColors.textGrey),
            ],
          ),
        ),
      );
}

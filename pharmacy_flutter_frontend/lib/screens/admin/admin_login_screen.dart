import 'package:flutter/material.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/screens/admin/admin_panel.dart';
import 'package:pharmacyapp/screens/login_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

/// Standalone admin login screen (deep link from main login).
/// The same /auth/login endpoint is used; role=='admin' routes here.
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailCtrl    = TextEditingController(text: 'admin@pharmacy.com');
  final _passwordCtrl = TextEditingController(text: 'admin123');
  bool _loading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
      showError(context, 'Please fill all fields');
      return;
    }
    setState(() => _loading = true);
    try {
      final data = await ApiService.login(
          _emailCtrl.text.trim(), _passwordCtrl.text.trim());
      final user  = data['user'] as Map<String, dynamic>;
      final token = data['token'] as String;

      if (user['role'] != 'admin') {
        showError(context, 'Access denied: not an admin account');
        return;
      }

      await TokenStorage.save(
        token: token,
        role:  'admin',
        name:  user['name'] ?? '',
        email: user['email'] ?? '',
        id:    user['id'] ?? 0,
      );

      if (!mounted) return;
      showSuccess(context, 'Welcome, Admin!');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AdminPanel()),
          (_) => false);
    } catch (e) {
      if (mounted) showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // ── Dark-blue header ─────────────────────────────────────────
          Container(
            width: double.infinity,
            height: h * 0.48,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F1F4B), Color(0xFF1E3A8A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(48),
                bottomRight: Radius.circular(48),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(31),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.admin_panel_settings_rounded,
                        size: 52, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text('Admin Panel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  const Text('Secure Access Only',
                      style:
                          TextStyle(color: Colors.white60, fontSize: 15)),
                ],
              ),
            ),
          ),

          // ── Form ────────────────────────────────────────────────────
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: h * 0.32, left: 20, right: 20, bottom: 30),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 20,
                      spreadRadius: 2)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Admin Login',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  const Text('Only authorized admins can access',
                      style: TextStyle(
                          color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 24),

                  AppTextField(
                    controller: _emailCtrl,
                    label: 'Admin Email',
                    hint: 'admin@pharmacy.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password with toggle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Password',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _passwordCtrl,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          hintStyle: const TextStyle(
                              color: AppColors.textGrey),
                          prefixIcon: const Icon(Icons.lock_outlined,
                              color: AppColors.primary, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textGrey,
                              size: 20,
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF1F5FB),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  PrimaryButton(
                    label: 'Login as Admin',
                    onTap: _login,
                    isLoading: _loading,
                    color: const Color(0xFF0F1F4B),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen())),
                      child: const Text('← Back to User Login',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/screens/signup_screen.dart';
import 'package:pharmacyapp/screens/main_nav.dart';
import 'package:pharmacyapp/screens/admin/admin_panel.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading       = false;
  bool _obscure       = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email    = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showError(context, 'Please enter email and password');
      return;
    }

    setState(() => _loading = true);

    try {
      final data = await ApiService.login(email, password);
      final user  = data['user'] as Map<String, dynamic>;
      final token = data['token'] as String;

      await TokenStorage.save(
        token: token,
        role:  user['role'] ?? 'user',
        name:  user['name'] ?? '',
        email: user['email'] ?? '',
        id:    user['id'] ?? 0,
      );

      if (!mounted) return;
      showSuccess(context, 'Welcome back, ${user['name']}!');

      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;

      if (user['role'] == 'admin') {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const AdminPanel()),
            (_) => false);
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const MainNav()),
            (_) => false);
      }
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
          // ── Blue header ──────────────────────────────────────────────────
          GradientHeader(
            heightFactor: 0.48,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(38),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.local_pharmacy,
                        size: 52, color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  const Text('Pharmacy App',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text('Welcome Back!',
                      style: TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
            ),
          ),

          // ── Form card ────────────────────────────────────────────────────
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
                  const Text('Sign In',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  const Text('Enter your credentials to continue',
                      style: TextStyle(
                          color: AppColors.textGrey, fontSize: 14)),
                  const SizedBox(height: 24),

                  // Email
                  AppTextField(
                    controller: _emailCtrl,
                    label: 'Email Address',
                    hint: 'you@gmail.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password
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
                          hintStyle:
                              const TextStyle(color: AppColors.textGrey),
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

                  const SizedBox(height: 24),

                  PrimaryButton(
                    label: 'Login',
                    onTap: _login,
                    isLoading: _loading,
                  ),

                  const SizedBox(height: 16),

                  // Admin login shortcut
                  PrimaryButton(
                    label: 'Login as Admin',
                    onTap: () {
                      _emailCtrl.text    = 'admin@pharmacy.com';
                      _passwordCtrl.text = 'admin123';
                      _login();
                    },
                    isLoading: false,
                    color: AppColors.textDark,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?  ",
                          style: TextStyle(color: AppColors.textGrey)),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupScreen())),
                        child: const Text('Sign Up',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
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

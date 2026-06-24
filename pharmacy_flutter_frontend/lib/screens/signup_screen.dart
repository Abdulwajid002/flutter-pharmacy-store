import 'package:flutter/material.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/screens/login_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl     = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl  = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final name     = _nameCtrl.text.trim();
    final email    = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();
    final confirm  = _confirmCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showError(context, 'Please fill all fields');
      return;
    }
    if (password != confirm) {
      showError(context, 'Passwords do not match');
      return;
    }

    setState(() => _loading = true);
    try {
      await ApiService.register(name, email, password);
      if (!mounted) return;
      showSuccess(context, 'Account created! Please login.');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
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
          // Header
          GradientHeader(
            heightFactor: 0.45,
            colors: const [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
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
                    child: const Icon(Icons.person_add,
                        size: 52, color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  const Text('Join Us',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text('Create your account',
                      style:
                          TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
            ),
          ),

          // Form
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: h * 0.30, left: 20, right: 20, bottom: 30),
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
                  const Text('Create Account',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  const Text('Fill in your details to get started',
                      style:
                          TextStyle(color: AppColors.textGrey, fontSize: 14)),
                  const SizedBox(height: 24),

                  AppTextField(
                    controller: _nameCtrl,
                    label: 'Full Name',
                    hint: 'Your Name',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 14),

                  AppTextField(
                    controller: _emailCtrl,
                    label: 'Email',
                    hint: 'you@gmail.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),

                  AppTextField(
                    controller: _passwordCtrl,
                    label: 'Password',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outlined,
                    obscure: true,
                  ),
                  const SizedBox(height: 14),

                  AppTextField(
                    controller: _confirmCtrl,
                    label: 'Confirm Password',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscure: true,
                  ),
                  const SizedBox(height: 24),

                  PrimaryButton(
                    label: 'Create Account',
                    onTap: _register,
                    isLoading: _loading,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?  ',
                          style:
                              TextStyle(color: AppColors.textGrey)),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen())),
                        child: const Text('Login',
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

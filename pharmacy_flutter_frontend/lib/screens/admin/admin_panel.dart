import 'package:flutter/material.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/screens/admin/add_product_screen.dart';
import 'package:pharmacyapp/screens/admin/admin_medicines_screen.dart';
import 'package:pharmacyapp/screens/admin/admin_orders_screen.dart';
import 'package:pharmacyapp/screens/admin/admin_users_screen.dart';
import 'package:pharmacyapp/screens/login_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});
  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  Map<String, dynamic>? _stats;
  bool _loading = true;
  String _adminName = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _adminName = (await TokenStorage.getName()) ?? 'Admin';
    setState(() => _loading = true);
    try {
      final data = await ApiService.getAdminDashboard();
      setState(() {
        _stats   = data;
        _loading = false;
      });
    } catch (e) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFF0F1F4B),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: _load),
          IconButton(
              icon: const Icon(Icons.logout_rounded), onPressed: _logout),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                  color: AppColors.primary))
          : RefreshIndicator(
              onRefresh: _load,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome banner
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0F1F4B), Color(0xFF1E3A8A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(38),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                                Icons.admin_panel_settings_rounded,
                                color: Colors.white,
                                size: 30),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Welcome back,',
                                  style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 13)),
                              Text(_adminName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Stats grid
                    const Text('Overview',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark)),
                    const SizedBox(height: 12),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.6,
                      children: [
                        _StatCard(
                            label: 'Total Users',
                            value: '${_stats?['totalUsers'] ?? 0}',
                            icon: Icons.people_rounded,
                            color: AppColors.primary),
                        _StatCard(
                            label: 'Total Orders',
                            value: '${_stats?['totalOrders'] ?? 0}',
                            icon: Icons.receipt_long_rounded,
                            color: AppColors.success),
                        _StatCard(
                            label: 'Medicines',
                            value: '${_stats?['totalMedicines'] ?? 0}',
                            icon: Icons.medication_rounded,
                            color: const Color(0xFFF59E0B)),
                        _StatCard(
                            label: 'Revenue',
                            value: '\$${_stats?['totalRevenue'] ?? 0}',
                            icon: Icons.attach_money_rounded,
                            color: AppColors.accent),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Quick actions
                    const Text('Quick Actions',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark)),
                    const SizedBox(height: 12),

                    _ActionTile(
                      icon: Icons.add_box_rounded,
                      label: 'Add New Product',
                      subtitle: 'Add medicine to the store',
                      color: AppColors.primary,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AddProductScreen())),
                    ),
                    const SizedBox(height: 10),
                    _ActionTile(
                      icon: Icons.medication_rounded,
                      label: 'Manage Medicines',
                      subtitle: 'Edit or remove medicines',
                      color: const Color(0xFFF59E0B),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const AdminMedicinesScreen())),
                    ),
                    const SizedBox(height: 10),
                    _ActionTile(
                      icon: Icons.receipt_long_rounded,
                      label: 'View All Orders',
                      subtitle: 'Manage customer orders',
                      color: AppColors.success,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const AdminOrdersScreen())),
                    ),
                    const SizedBox(height: 10),
                    _ActionTile(
                      icon: Icons.people_rounded,
                      label: 'Manage Users',
                      subtitle: 'View all registered users',
                      color: AppColors.accent,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AdminUsersScreen())),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _StatCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(38)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 26),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(
                      color: color,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
              Text(label,
                  style: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label, subtitle;
  final Color color;
  final VoidCallback onTap;
  const _ActionTile(
      {required this.icon,
      required this.label,
      required this.subtitle,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.textDark)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: AppColors.textGrey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}

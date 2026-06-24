import 'package:flutter/material.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});
  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  List<dynamic> _orders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final data = await ApiService.adminGetOrders();
      setState(() {
        _orders  = data;
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        showError(context, e.toString());
        setState(() => _loading = false);
      }
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':  return AppColors.success;
      case 'pending':    return const Color(0xFFF59E0B);
      case 'cancelled':  return AppColors.error;
      default:           return AppColors.textGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('All Orders'),
        backgroundColor: const Color(0xFF0F1F4B),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh_rounded), onPressed: _load),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : _orders.isEmpty
              ? const Center(
                  child: Text('No orders found',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 16)))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _orders.length,
                    itemBuilder: (_, i) {
                      final o      = _orders[i];
                      final status = (o['status'] ?? 'pending') as String;
                      final color  = _statusColor(status);
                      final total  = double.tryParse(o['total'].toString()) ?? 0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: color.withAlpha(26),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(Icons.receipt_long_rounded,
                                        color: color, size: 22),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          o['medicine_name'] ?? 'Unknown',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15,
                                              color: AppColors.textDark),
                                        ),
                                        Text(
                                          'Qty: ${o['quantity'] ?? 1}  •  User: ${o['user_name'] ?? o['user_id'] ?? '-'}',
                                          style: const TextStyle(
                                              color: AppColors.textGrey,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${total.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                            color: AppColors.success),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: color.withAlpha(26),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          status.toUpperCase(),
                                          style: TextStyle(
                                              color: color,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (o['created_at'] != null) ...[
                                const SizedBox(height: 10),
                                const Divider(height: 1),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined,
                                        size: 12, color: AppColors.textGrey),
                                    const SizedBox(width: 4),
                                    Text(
                                      (o['created_at'] as String).length >= 10
                                          ? (o['created_at'] as String).substring(0, 10)
                                          : o['created_at'],
                                      style: const TextStyle(
                                          color: AppColors.textGrey, fontSize: 12),
                                    ),
                                    const SizedBox(width: 12),
                                    Text('Order #${o['id']}',
                                        style: const TextStyle(
                                            color: AppColors.textGrey, fontSize: 12)),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pharmacyapp/models/medicine.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/screens/main_nav.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class CheckoutScreen extends StatefulWidget {
  final Medicine medicine;
  final int quantity;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.medicine,
    required this.quantity,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _loading = false;

  Future<void> _placeOrder() async {
    setState(() => _loading = true);
    try {
      await ApiService.placeOrder(
        medicineName: widget.medicine.name,
        quantity: widget.quantity,
        total: widget.total,
      );

      if (!mounted) return;
      showSuccess(context, ' Order placed successfully!');

      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainNav()),
          (_) => false);
    } catch (e) {
      if (mounted) showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final med = widget.medicine;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Order Summary ──────────────────────────────────────
                  const Text('Order Summary',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark)),
                  const SizedBox(height: 12),

                  AppCard(
                    child: Column(
                      children: [
                        _summaryRow('Medicine', med.name),
                        const SizedBox(height: 10),
                        _summaryRow('Category', med.category),
                        const SizedBox(height: 10),
                        _summaryRow(
                            'Unit Price',
                            '\$${med.price.toStringAsFixed(0)}'),
                        const SizedBox(height: 10),
                        _summaryRow('Quantity', '${widget.quantity}'),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(),
                        ),
                        _summaryRow(
                          'Total',
                          '\$${widget.total.toStringAsFixed(0)}',
                          bold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Payment method ─────────────────────────────────────
                  const Text('Payment Method',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark)),
                  const SizedBox(height: 12),

                  AppCard(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(26),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                              Icons.account_balance_wallet_rounded,
                              color: AppColors.primary),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Wallet Balance',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                              Text('Amount will be deducted from wallet',
                                  style: TextStyle(
                                      color: AppColors.textGrey,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        const Icon(Icons.check_circle_rounded,
                            color: AppColors.success),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Info note ──────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(13),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.primary.withAlpha(51)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: AppColors.primary, size: 18),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'The total amount will be deducted from your wallet. Ensure you have sufficient balance.',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 13,
                                height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Place Order button ─────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: PrimaryButton(
                label: 'Place Order  •  \$${widget.total.toStringAsFixed(0)}',
                onTap: _placeOrder,
                isLoading: _loading,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppColors.textGrey, fontSize: 14)),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
                  fontSize: bold ? 16 : 14,
                  color: bold ? AppColors.success : AppColors.textDark)),
        ],
      );
}

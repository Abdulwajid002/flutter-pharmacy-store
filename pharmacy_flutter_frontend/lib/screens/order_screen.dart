import 'package:flutter/material.dart';
import 'package:pharmacyapp/models/medicine.dart';
import 'package:pharmacyapp/screens/checkout_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class OrderScreen extends StatefulWidget {
  final Medicine medicine;
  final int quantity;
  const OrderScreen({super.key, required this.medicine, required this.quantity});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final med      = widget.medicine;
    final subtotal = med.price * _qty;
    const delivery = 20.0;
    final total    = subtotal + delivery;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(title: const Text('Order Review')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ── Medicine card ──────────────────────────────────────
                  AppCard(
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F4FF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Icon(Icons.medication_rounded,
                                size: 48,
                                color:
                                    AppColors.primary.withAlpha(153)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(med.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: AppColors.textDark)),
                              const SizedBox(height: 4),
                              Text(med.category,
                                  style: const TextStyle(
                                      color: AppColors.textGrey,
                                      fontSize: 13)),
                              const SizedBox(height: 8),
                              Text(
                                  '\$${med.price.toStringAsFixed(0)} / unit',
                                  style: const TextStyle(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                            ],
                          ),
                        ),

                        // Qty controls
                        Column(
                          children: [
                            _qBtn(Icons.add, AppColors.success,
                                () => setState(() => _qty++)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              child: Text('$_qty',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)),
                            ),
                            _qBtn(Icons.remove, AppColors.error, () {
                              if (_qty > 1) setState(() => _qty--);
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Price breakdown ────────────────────────────────────
                  AppCard(
                    child: Column(
                      children: [
                        _priceRow('Subtotal', '\$${subtotal.toStringAsFixed(0)}'),
                        const SizedBox(height: 12),
                        _priceRow('Delivery Fee', '\$${delivery.toStringAsFixed(0)}'),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(),
                        ),
                        _priceRow('Total', '\$${total.toStringAsFixed(0)}',
                            bold: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Checkout button ────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: PrimaryButton(
                label: 'Proceed to Checkout',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      medicine: med,
                      quantity: _qty,
                      total: total,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qBtn(IconData icon, Color color, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color, size: 18),
        ),
      );

  Widget _priceRow(String label, String value, {bool bold = false}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: bold ? 17 : 15,
                  fontWeight:
                      bold ? FontWeight.w800 : FontWeight.w500,
                  color:
                      bold ? AppColors.textDark : AppColors.textGrey)),
          Text(value,
              style: TextStyle(
                  fontSize: bold ? 17 : 15,
                  fontWeight:
                      bold ? FontWeight.w800 : FontWeight.w600,
                  color: bold ? AppColors.success : AppColors.textDark)),
        ],
      );
}

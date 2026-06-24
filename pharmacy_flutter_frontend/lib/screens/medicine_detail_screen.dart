import 'package:flutter/material.dart';
import 'package:pharmacyapp/models/medicine.dart';
import 'package:pharmacyapp/screens/order_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class MedicineDetailScreen extends StatefulWidget {
  final Medicine medicine;
  const MedicineDetailScreen({super.key, required this.medicine});
  @override
  State<MedicineDetailScreen> createState() => _MedicineDetailScreenState();
}

class _MedicineDetailScreenState extends State<MedicineDetailScreen> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final med   = widget.medicine;
    final total = med.price * _qty;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(med.name),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.arrow_back_rounded,
                color: AppColors.textDark),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // ── Image area ─────────────────────────────────────────────────
          Container(
            height: 220,
            width: double.infinity,
            color: const Color(0xFFF0F4FF),
            child: Center(
              child: Icon(Icons.medication_rounded,
                  size: 110,
                  color: AppColors.primary.withAlpha(140)),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Price row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(med.name,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark)),
                      ),
                      Text('\$${med.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.success)),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Category chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(20),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(med.category,
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Description',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.textDark)),
                        const SizedBox(height: 8),
                        Text(
                          med.description.isEmpty
                              ? 'A trusted medicine for everyday health needs.'
                              : med.description,
                          style: const TextStyle(
                              color: AppColors.textGrey,
                              height: 1.5,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Stock row
                  AppCard(
                    child: Row(
                      children: [
                        const Icon(Icons.inventory_2_outlined,
                            color: AppColors.primary),
                        const SizedBox(width: 10),
                        Text('Stock: ${med.stock} units',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Qty selector
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Text('Quantity',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        const Spacer(),
                        _qtyBtn(
                            icon: Icons.remove,
                            color: AppColors.error,
                            onTap: () {
                              if (_qty > 1) setState(() => _qty--);
                            }),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('$_qty',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800)),
                        ),
                        _qtyBtn(
                            icon: Icons.add,
                            color: AppColors.success,
                            onTap: () => setState(() => _qty++)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom bar ─────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              color: AppColors.textGrey, fontSize: 13)),
                      Text('\$${total.toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Order Now',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderScreen(
                            medicine: med,
                            quantity: _qty,
                          ),
                        ),
                      ),
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

  Widget _qtyBtn(
          {required IconData icon,
          required Color color,
          required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 20),
        ),
      );
}

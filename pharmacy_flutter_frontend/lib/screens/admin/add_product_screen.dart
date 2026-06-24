import 'package:flutter/material.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class AddProductScreen extends StatefulWidget {
  final Map<String, dynamic>? existingMedicine; // non-null = edit mode
  const AddProductScreen({super.key, this.existingMedicine});
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameCtrl  = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl  = TextEditingController();
  final _stockCtrl = TextEditingController();

  String _selectedCategory = 'Medicine';
  bool   _loading          = false;

  final List<String> _categories = [
    'Medicine', 'Vitamins', 'Herbal', 'Supplement', 'Other'
  ];

  bool get _editMode => widget.existingMedicine != null;

  @override
  void initState() {
    super.initState();
    if (_editMode) {
      final m = widget.existingMedicine!;
      _nameCtrl.text  = m['name'] ?? '';
      _priceCtrl.text = m['price'].toString();
      _descCtrl.text  = m['description'] ?? '';
      _stockCtrl.text = m['stock']?.toString() ?? '10';
      _selectedCategory = m['category'] ?? 'Medicine';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    _stockCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name  = _nameCtrl.text.trim();
    final price = _priceCtrl.text.trim();
    final stock = _stockCtrl.text.trim();

    if (name.isEmpty || price.isEmpty) {
      showError(context, 'Name and price are required');
      return;
    }
    if (double.tryParse(price) == null) {
      showError(context, 'Enter a valid price');
      return;
    }

    setState(() => _loading = true);
    try {
      final payload = {
        'name':        name,
        'price':       double.parse(price),
        'category':    _selectedCategory,
        'description': _descCtrl.text.trim(),
        'stock':       int.tryParse(stock) ?? 100,
      };

      if (_editMode) {
        await ApiService.adminUpdateMedicine(
            widget.existingMedicine!['id'], payload);
        showSuccess(context, 'Product updated successfully!');
      } else {
        await ApiService.adminAddMedicine(payload);
        showSuccess(context, 'Product added successfully!');
        _clear();
      }

      if (!mounted) return;
      Navigator.pop(context, true); // return true = refresh parent
    } catch (e) {
      if (mounted) showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _clear() {
    _nameCtrl.clear();
    _priceCtrl.clear();
    _descCtrl.clear();
    _stockCtrl.clear();
    setState(() => _selectedCategory = 'Medicine');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(_editMode ? 'Edit Product' : 'Add Product'),
        backgroundColor: const Color(0xFF0F1F4B),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image placeholder ──────────────────────────────────────
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppColors.primary.withAlpha(51)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medication_rounded,
                      size: 60,
                      color: AppColors.primary.withAlpha(128)),
                  const SizedBox(height: 8),
                  const Text('Product Image',
                      style: TextStyle(
                          color: AppColors.textGrey, fontSize: 13)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            AppTextField(
              controller: _nameCtrl,
              label: 'Product Name *',
              hint: 'e.g. Panadol Extra',
              prefixIcon: Icons.medication_outlined,
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _priceCtrl,
              label: 'Price (USD) *',
              hint: 'e.g. 12.50',
              prefixIcon: Icons.attach_money_rounded,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),

            // Category dropdown
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Category',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primary),
                    items: _categories
                        .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c,
                                style: const TextStyle(fontSize: 15))))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _selectedCategory = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _stockCtrl,
              label: 'Stock Quantity',
              hint: 'e.g. 100',
              prefixIcon: Icons.inventory_2_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _descCtrl,
              label: 'Description',
              hint: 'Describe the product...',
              prefixIcon: Icons.description_outlined,
              maxLines: 4,
            ),

            const SizedBox(height: 28),

            PrimaryButton(
              label:     _editMode ? 'Update Product' : 'Add Product',
              onTap:     _submit,
              isLoading: _loading,
              color:     const Color(0xFF0F1F4B),
            ),
          ],
        ),
      ),
    );
  }
}

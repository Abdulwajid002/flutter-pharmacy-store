import 'package:flutter/material.dart';
import 'package:pharmacyapp/models/medicine.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/screens/admin/add_product_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class AdminMedicinesScreen extends StatefulWidget {
  const AdminMedicinesScreen({super.key});
  @override
  State<AdminMedicinesScreen> createState() => _AdminMedicinesScreenState();
}

class _AdminMedicinesScreenState extends State<AdminMedicinesScreen> {
  List<Medicine> _medicines = [];
  bool _loading             = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final data = await ApiService.getMedicines();
      setState(() {
        _medicines = data.map((e) => Medicine.fromJson(e)).toList();
        _loading   = false;
      });
    } catch (e) {
      if (mounted) {
        showError(context, e.toString());
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _delete(Medicine m) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Medicine'),
        content: Text('Are you sure you want to delete "${m.name}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ApiService.adminDeleteMedicine(m.id);
      showSuccess(context, '${m.name} deleted');
      await _load();
    } catch (e) {
      if (mounted) showError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Manage Medicines'),
        backgroundColor: const Color(0xFF0F1F4B),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_rounded),
              onPressed: () async {
                final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddProductScreen()));
                if (result == true) _load();
              }),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                  color: AppColors.primary))
          : _medicines.isEmpty
              ? const Center(
                  child: Text('No medicines found',
                      style: TextStyle(color: AppColors.textGrey)))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _medicines.length,
                    itemBuilder: (_, i) {
                      final m = _medicines[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: AppCard(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(20),
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                    Icons.medication_rounded,
                                    color: AppColors.primary,
                                    size: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(m.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Text(
                                        '${m.category}  •  \$${m.price.toStringAsFixed(0)}  •  Stock: ${m.stock}',
                                        style: const TextStyle(
                                            color: AppColors.textGrey,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.edit_outlined,
                                        color: AppColors.primary,
                                        size: 20),
                                    onPressed: () async {
                                      final result =
                                          await Navigator.push<bool>(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddProductScreen(
                                                          existingMedicine:
                                                              m.toJson())));
                                      if (result == true) _load();
                                    },
                                    tooltip: 'Edit',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: AppColors.error,
                                        size: 20),
                                    onPressed: () => _delete(m),
                                    tooltip: 'Delete',
                                  ),
                                ],
                              ),
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

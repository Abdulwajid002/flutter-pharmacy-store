import 'package:flutter/material.dart';
import 'package:pharmacyapp/models/medicine.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/screens/medicine_detail_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Medicine> _all      = [];
  List<Medicine> _filtered = [];
  String _selectedCat      = 'All';
  bool _loading            = true;
  String _search           = '';

  final List<String> _categories = ['All', 'Medicine', 'Vitamins', 'Herbal', 'Supplement'];

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
  }

  Future<void> _fetchMedicines() async {
    setState(() => _loading = true);
    try {
      final data = await ApiService.getMedicines();
      final meds = data.map((e) => Medicine.fromJson(e)).toList();
      setState(() {
        _all      = meds;
        _filtered = meds;
        _loading  = false;
      });
    } catch (e) {
      if (mounted) {
        showError(context, e.toString());
        setState(() => _loading = false);
      }
    }
  }

  void _applyFilter() {
    setState(() {
      _filtered = _all.where((m) {
        final matchCat    = _selectedCat == 'All' ||
            m.category.toLowerCase() == _selectedCat.toLowerCase();
        final matchSearch = _search.isEmpty ||
            m.name.toLowerCase().contains(_search.toLowerCase());
        return matchCat && matchSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Pharmacy App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _fetchMedicines,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Search bar ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (v) {
                _search = v;
                _applyFilter();
              },
              decoration: InputDecoration(
                hintText: 'Search medicines...',
                hintStyle: const TextStyle(color: AppColors.textGrey),
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ── Categories ──────────────────────────────────────────────────
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (_, i) {
                final cat    = _categories[i];
                final active = cat == _selectedCat;
                return GestureDetector(
                  onTap: () {
                    _selectedCat = cat;
                    _applyFilter();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: active ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: active
                          ? [
                              BoxShadow(
                                  color: AppColors.primary.withAlpha(64),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3))
                            ]
                          : [],
                    ),
                    child: Text(cat,
                        style: TextStyle(
                            color:
                                active ? Colors.white : AppColors.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // ── Grid ────────────────────────────────────────────────────────
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primary))
                : _filtered.isEmpty
                    ? _emptyState()
                    : RefreshIndicator(
                        onRefresh: _fetchMedicines,
                        color: AppColors.primary,
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: _filtered.length,
                          itemBuilder: (_, i) =>
                              _MedicineCard(medicine: _filtered[i]),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medication_outlined,
                size: 64, color: AppColors.textGrey.withAlpha(102)),
            const SizedBox(height: 12),
            const Text('No medicines found',
                style: TextStyle(color: AppColors.textGrey, fontSize: 16)),
          ],
        ),
      );
}

// ── Medicine grid card ────────────────────────────────────────────────────────
class _MedicineCard extends StatelessWidget {
  final Medicine medicine;
  const _MedicineCard({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MedicineDetailScreen(medicine: medicine)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0A000000), blurRadius: 10, spreadRadius: 1)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18)),
                ),
                child: Center(
                    child: Center(
                      child: Image.asset(
                        medicine.imageUrl,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.medication_rounded,
                          size: 64,
                          color: AppColors.primary.withAlpha(153),
                        ),
                      ),
                    ),
                ),
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.textDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    medicine.category,
                    style: const TextStyle(
                        color: AppColors.textGrey, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${medicine.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

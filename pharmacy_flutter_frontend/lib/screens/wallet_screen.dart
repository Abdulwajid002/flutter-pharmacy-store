import 'package:flutter/material.dart';
import 'package:pharmacyapp/models/transaction.dart';
import 'package:pharmacyapp/services/api_service.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double _balance             = 0;
  List<WalletTransaction> _tx = [];
  bool _loading               = true;
  bool _adding                = false;

  @override
  void initState() {
    super.initState();
    _loadWallet();
  }

  Future<void> _loadWallet() async {
    setState(() => _loading = true);
    try {
      final data = await ApiService.getWallet();
      setState(() {
        _balance = double.tryParse(data['balance'].toString()) ?? 0;
        final txList = data['transactions'] as List? ?? [];
        _tx = txList.map((e) => WalletTransaction.fromJson(e)).toList();
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        showError(context, e.toString());
        setState(() => _loading = false);
      }
    }
  }

  void _showAddMoneyDialog() {
    final ctrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Add Money',
            style: TextStyle(fontWeight: FontWeight.w800)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter amount to add to your wallet',
                style: TextStyle(
                    color: AppColors.textGrey, fontSize: 13)),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'e.g. 100',
                prefixText: '\$ ',
                filled: true,
                fillColor: const Color(0xFFF1F5FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              final amount = double.tryParse(ctrl.text.trim());
              if (amount == null || amount <= 0) {
                showError(context, 'Enter a valid amount');
                return;
              }
              Navigator.pop(context);
              await _addMoney(amount);
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _addMoney(double amount) async {
    setState(() => _adding = true);
    try {
      await ApiService.addMoney(amount);
      showSuccess(context,
          '\$${amount.toStringAsFixed(0)} added successfully!');
      await _loadWallet();
    } catch (e) {
      if (mounted) showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _adding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('My Wallet'),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: _loadWallet),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : RefreshIndicator(
              onRefresh: _loadWallet,
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Balance card ─────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withAlpha(89),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: Colors.white70,
                                  size: 20),
                              const SizedBox(width: 6),
                              const Text('Available Balance',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '\$${_balance.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _adding ? null : _showAddMoneyDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12),
                              ),
                              icon: _adding
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.primary))
                                  : const Icon(Icons.add_rounded),
                              label: Text(
                                  _adding ? 'Processing...' : 'Add Money',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Transactions ─────────────────────────────────────
                    const Text('Recent Transactions',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark)),
                    const SizedBox(height: 14),

                    _tx.isEmpty
                        ? AppCard(
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.receipt_long_outlined,
                                      size: 48,
                                      color: AppColors.textGrey
                                          .withAlpha(102)),
                                  const SizedBox(height: 10),
                                  const Text('No transactions yet',
                                      style: TextStyle(
                                          color: AppColors.textGrey)),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: _tx
                                .map((tx) => _TransactionTile(tx: tx))
                                .toList(),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final WalletTransaction tx;
  const _TransactionTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isCredit = tx.isCredit;
    final color    = isCredit ? AppColors.success : AppColors.error;
    final icon     = isCredit ? Icons.arrow_downward_rounded
                              : Icons.arrow_upward_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.description.isEmpty ? 'Transaction' : tx.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.textDark),
                  ),
                  if (tx.createdAt.isNotEmpty)
                    Text(tx.createdAt.substring(0, 10),
                        style: const TextStyle(
                            color: AppColors.textGrey, fontSize: 12)),
                ],
              ),
            ),
            Text(
              '${isCredit ? '+' : '-'}\$${tx.amount.toStringAsFixed(2)}',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: color),
            ),
          ],
        ),
      ),
    );
  }
}

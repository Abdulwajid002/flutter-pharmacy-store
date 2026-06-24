class WalletTransaction {
  final int id;
  final String type;   // 'credit' | 'debit'
  final double amount;
  final String description;
  final String createdAt;

  WalletTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id:          json['id'] ?? 0,
      type:        json['type'] ?? 'credit',
      amount:      double.tryParse(json['amount'].toString()) ?? 0.0,
      description: json['description'] ?? '',
      createdAt:   json['created_at'] ?? '',
    );
  }

  bool get isCredit => type == 'credit';
}

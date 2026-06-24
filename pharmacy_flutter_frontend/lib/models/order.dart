class Order {
  final int id;
  final String medicineName;
  final int quantity;
  final double total;
  final String status;
  final String createdAt;

  Order({
    required this.id,
    required this.medicineName,
    required this.quantity,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id:           json['id'] ?? 0,
      medicineName: json['medicine_name'] ?? '',
      quantity:     json['quantity'] ?? 1,
      total:        double.tryParse(json['total'].toString()) ?? 0.0,
      status:       json['status'] ?? 'pending',
      createdAt:    json['created_at'] ?? '',
    );
  }
}

class Medicine {
  final int id;
  final String name;
  final double price;
  final String category;
  final String description;
  final int stock;
  final String imageUrl;

  Medicine({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.stock,
    required this.imageUrl,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id:          json['id'] ?? 0,
      name:        json['name'] ?? '',
      price:       double.tryParse(json['price'].toString()) ?? 0.0,
      category:    json['category'] ?? '',
      description: json['description'] ?? '',
      stock:       json['stock'] ?? 0,
      imageUrl:    json['image_url'] ?? 'images/medicine.png',
    );
  }

  Map<String, dynamic> toJson() => {
    'id':          id,
    'name':        name,
    'price':       price,
    'category':    category,
    'description': description,
    'stock':       stock,
    'image_url':   imageUrl,
  };
}

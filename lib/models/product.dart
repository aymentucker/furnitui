class Product {
  final String name;
  final String category;
  final double price;
  final String image;
  final bool hasDiscount;
  final String? discountLabel;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.hasDiscount,
    this.discountLabel,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      category: json['category'],
      price: json['price'],
      image: json['image'],
      hasDiscount: json['hasDiscount'],
      discountLabel: json['discountLabel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'image': image,
      'hasDiscount': hasDiscount,
      'discountLabel': discountLabel,
    };
  }
}

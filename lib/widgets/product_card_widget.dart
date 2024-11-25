import 'dart:math';
import 'package:flutter/material.dart';
import 'package:furnitui/screens/product.dart';

Color _generateRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}

Widget productCard(BuildContext context, Map<String, dynamic> product, int index) {
  final randomColor = _generateRandomColor();

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductScreen(
            imageTag: 'productImage$index',
            selectedColor: randomColor, // Pass the random color to ProductScreen
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: randomColor.withOpacity(0.1), // Apply random color with slight transparency
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Hero(
                    tag: 'productImage$index',
                    child: Image.asset(
                      product["image"],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "\$${product["price"].toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
            ],
          ),
          if (product["hasDiscount"] ?? false)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: randomColor, // Use the same random color for the discount badge
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  product["discountLabel"] ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

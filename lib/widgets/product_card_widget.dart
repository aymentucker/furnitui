import 'package:flutter/material.dart';
import 'package:furnitui/screens/product.dart';
import 'package:furnitui/utils/colors.dart';

Widget productCard(BuildContext context, int index) {
  List<String> productImages = [
    'assets/images/product1.png',
    'assets/images/product2.png',
    'assets/images/product3.png',
    'assets/images/product4.png',
  ];

  List<double> productPrices = [199.00, 149.00, 249.00, 129.00]; // Sample product prices
  List<bool> hasDiscount = [false, false, true, false]; // Indicates if product has discount
  List<String> discountLabels = ['-25%']; // Sample discount label

  return GestureDetector(
    onTap: () {
      // Navigate to ProductScreen and pass the selected product's details
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductScreen(
            imageTag: 'productImage$index', // Pass the unique tag for Hero animation
            selectedColor: Colors.brown, // Pass any necessary data
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColors.secondaryColor,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              // Product image with Hero animation
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Hero(
                    tag: 'productImage$index', // Unique tag for Hero animation
                    child: Image.asset(
                      productImages[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Product price
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "\$${productPrices[index].toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          // Discount badge (if applicable)
          if (hasDiscount[index])
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDA7635), // Same as button color in the design
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  discountLabels[0], // Use '-25%' as sample discount
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

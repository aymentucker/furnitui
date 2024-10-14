import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furnitui/utils/colors.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Dummy data for favorite products
  List<Map<String, dynamic>> favoriteProducts = [
    // Initially non-empty list. You can remove the items to test the empty state.
    {
      'title': 'Minimalist Chair',
      'subtitle': 'Black',
      'quantity': 1,
      'price': 854.08,
      'imageAsset': 'assets/images/product1.png'
    },
    {
      'title': 'Modern Lamp',
      'subtitle': 'White',
      'quantity': 1,
      'price': 120.00,
      'imageAsset': 'assets/images/product2.png'
    },
    {
      'title': 'Wooden Coffee Table',
      'subtitle': 'Brown',
      'quantity': 1,
      'price': 350.00,
      'imageAsset': 'assets/images/product3.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyColors.primaryColor,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyColors.primaryColor,
                MyColors.primaryColor.withOpacity(0.9)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: favoriteProducts.isEmpty
            ? _buildEmptyState() // If empty, show empty state
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return _buildFavoriteCard(
                    product['title'],
                    product['subtitle'],
                    product['quantity'],
                    product['price'],
                    product['imageAsset'],
                    index,
                  );
                },
              ),
      ),
    );
  }

  // Widget for individual product card with the same design as CartItem
  Widget _buildFavoriteCard(String title, String subtitle, int quantity,
      double price, String imageAsset, int index) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageAsset,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12), // Spacing between image and text

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Remove from favorites button
            IconButton(
              icon: Icon(Icons.delete_outline, color: MyColors.primaryColor),
              onPressed: () {
                setState(() {
                  favoriteProducts.removeAt(index); // Remove item from favorites
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Build the empty state when no favorite products exist
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: MyColors.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            'No favorites yet',
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: MyColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Add products to your favorites.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

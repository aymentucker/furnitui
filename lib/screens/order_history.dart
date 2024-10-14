import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furnitui/utils/colors.dart';
import 'package:furnitui/widgets/order_card_widget.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  // Dummy data for order history
  List<Map<String, dynamic>> orderHistory = [
    {
      'orderId': 'ORD12345',
      'orderDate': '12 Sep, 2024',
      'totalPrice': 1200.50,
      'items': 3,
      'products': [
        {'name': 'Minimalist Chair', 'quantity': 1, 'price': 854.08},
        {'name': 'Modern Lamp', 'quantity': 1, 'price': 120.00},
        {'name': 'Wooden Coffee Table', 'quantity': 1, 'price': 350.00},
      ],
      'imageAsset': 'assets/images/product1.png'
    },
    {
      'orderId': 'ORD54321',
      'orderDate': '5 Sep, 2024',
      'totalPrice': 750.30,
      'items': 2,
      'products': [
        {'name': 'Chair', 'quantity': 1, 'price': 450.30},
        {'name': 'Table', 'quantity': 1, 'price': 300.00},
      ],
      'imageAsset': 'assets/images/product2.png'
    },
    {
      'orderId': 'ORD67890',
      'orderDate': '25 Aug, 2024',
      'totalPrice': 350.00,
      'items': 1,
      'products': [
        {'name': 'Coffee Table', 'quantity': 1, 'price': 350.00},
      ],
      'imageAsset': 'assets/images/product3.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
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
        child: orderHistory.isEmpty
            ? _buildEmptyState() // If empty, show empty state
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  final order = orderHistory[index];
                  return buildOrderCard(
                    context,
                    order['orderId'],
                    order['orderDate'],
                    order['items'],
                    order['totalPrice'],
                    order['imageAsset'],
                    order['products'], // Pass product details
                    index,
                  );
                },
              ),
      ),
    );
  }

  // Build the empty state when no orders exist
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 100,
            color: MyColors.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            'No orders yet',
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: MyColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Browse products and place an order.',
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

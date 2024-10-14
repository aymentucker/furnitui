import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furnitui/utils/colors.dart';
import 'order_details_dialog.dart';

Widget buildOrderCard(BuildContext context, String orderId, String orderDate, int items,
    double totalPrice, String imageAsset, List products, int index) {
  return Card(
    color: Colors.white,
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageAsset,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12), // Spacing between image and text

          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order ID: $orderId",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Order Date: $orderDate",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Items: $items",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Total: \$${totalPrice.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MyColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Buttons Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // View Details Button
              IconButton(
                icon: Icon(Icons.info_outline, color: MyColors.primaryColor),
                onPressed: () {
                  showOrderDetails(context, orderId, orderDate, items, totalPrice, products);
                },
              ),
              const SizedBox(height: 8),

              // Reorder Button
              ElevatedButton(
                onPressed: () {
                  // Implement reorder logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                child: Text(
                  "Reorder",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

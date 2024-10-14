import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furnitui/utils/colors.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  // Dummy data for notifications
  List<Map<String, dynamic>> todayNotifications = [
    {
      'title': 'Your Order Will Be Shipped',
      'subtitle': 'Once We Get Confirm Address',
      'time': '16 minutes ago',
      'imageAsset': 'assets/images/product1.png',
    },
    {
      'title': 'Special Offer on Bean',
      'subtitle': 'Upto 46% Off All The Products',
      'time': '26 minutes ago',
      'imageAsset': null,
    },
    {
      'title': 'New Products You May Like',
      'subtitle': 'Go And Show Now',
      'time': '49 minutes ago',
      'imageAsset': 'assets/images/product2.png',
    },
    {
      'title': 'Your Order 3 Summer Green Chair',
      'subtitle': 'Has Been Shipped!',
      'time': '16 days ago',
      'imageAsset': 'assets/images/product3.png',
      'isLocked': true, // For displaying lock icon
    },
  ];

  List<Map<String, dynamic>> yesterdayNotifications = [
    {
      'title': 'Your Order Will Be Shipped',
      'subtitle': 'Once We Get Confirm Address',
      'time': '16 minutes ago',
      'imageAsset': 'assets/images/product1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                todayNotifications.clear();
                yesterdayNotifications.clear();
              });
            },
            child: Text(
              "Clear All",
              style: GoogleFonts.poppins(
                color: MyColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (todayNotifications.isNotEmpty) ...[
            _buildSectionTitle("Today"),
            const SizedBox(height: 10),
            ...todayNotifications.map((notification) {
              return _buildNotificationCard(notification);
            }).toList(),
            const SizedBox(height: 20),
          ],
          if (yesterdayNotifications.isNotEmpty) ...[
            _buildSectionTitle("Yesterday"),
            const SizedBox(height: 10),
            ...yesterdayNotifications.map((notification) {
              return _buildNotificationCard(notification);
            }).toList(),
          ],
        ],
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // Notification Card with Improved UI Design
  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          todayNotifications.remove(notification);
        });
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification Image if exists
              if (notification['imageAsset'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    notification['imageAsset'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              if (notification['imageAsset'] != null)
                const SizedBox(width: 12), // Spacing between image and text

              // Notification Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification['title'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['subtitle'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification['time'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Lock icon for locked notifications
              if (notification['isLocked'] != null)
                Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

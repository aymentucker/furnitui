import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furnitui/screens/order_history.dart';
import 'package:furnitui/screens/payment_methods.dart';
import 'package:furnitui/screens/profile.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        // Drawer Header with profile picture and user details
        const UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          currentAccountPicture: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile_picture.png'),
            backgroundColor: Colors.transparent,
          ),
          accountName: Text(
            'Marvin McKinney',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          accountEmail: Text(
            'marvin952@gmail.com',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),

        // Profile list items with FontAwesome icons and clean design
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.user,
                      color: Colors.black87),
                  title: const Text('Profile',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    ).then((_) => Navigator.pop(context)); // Close the Drawer
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.creditCard,
                      color: Colors.black87),
                  title: const Text('Payment Methods',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethodsScreen()),
                    ).then((_) => Navigator.pop(context)); // Close the Drawer
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.shoppingBag,
                      color: Colors.black87),
                  title: const Text('Order History',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderHistoryScreen()),
                    ).then((_) => Navigator.pop(context)); // Close the Drawer
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.mapMarkerAlt,
                      color: Colors.black87),
                  title: const Text('Delivery Address',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(context); // Close the Drawer
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.headset,
                      color: Colors.black87),
                  title: const Text('Support Center',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(context); // Close the Drawer
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.fileAlt,
                      color: Colors.black87),
                  title: const Text('Legal Policy',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(context); // Close the Drawer
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.signOutAlt,
                      color: Colors.redAccent),
                  title: const Text('Log Out',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.pop(context); // Close the Drawer
                    // Add logout logic here
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

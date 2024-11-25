import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furnitui/screens/order_history.dart';
import 'package:furnitui/screens/payment_methods.dart';
import 'package:furnitui/screens/profile.dart';

Widget _buildDrawer(BuildContext context) {
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
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.user, color: Colors.black87),
          title: const Text('Profile',
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading:
              const FaIcon(FontAwesomeIcons.creditCard, color: Colors.black87),
          title: const Text('Payment Methods',
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentMethodsScreen()));
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading:
              const FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.black87),
          title: const Text('Order History',
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderHistoryScreen()));

            Navigator.pop(context);
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.mapMarkerAlt,
              color: Colors.black87),
          title: const Text('Delivery Address',
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading:
              const FaIcon(FontAwesomeIcons.headset, color: Colors.black87),
          title: const Text('Support Center',
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading:
              const FaIcon(FontAwesomeIcons.fileAlt, color: Colors.black87),
          title: const Text('Legal Policy',
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.signOutAlt,
              color: Colors.redAccent),
          title: const Text('Log Out',
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

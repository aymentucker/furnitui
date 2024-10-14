import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        // Drawer Header with profile picture and user details
        UserAccountsDrawerHeader(
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
          leading: FaIcon(FontAwesomeIcons.user, color: Colors.black87),
          title: Text('Profile', style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(height: 1),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.creditCard, color: Colors.black87),
          title: Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(height: 1),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.black87),
          title: Text('Order History', style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(height: 1),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.mapMarkerAlt, color: Colors.black87),
          title: Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(height: 1),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.headset, color: Colors.black87),
          title: Text('Support Center', style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(height: 1),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.fileAlt, color: Colors.black87),
          title: Text('Legal Policy', style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(height: 1),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.redAccent),
          title: Text('Log Out', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

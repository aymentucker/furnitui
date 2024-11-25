import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furnitui/utils/colors.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // Toggle state for switches
  bool faceIdEnabled = false;
  bool pushNotificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account Section
          _buildSectionTitle("Account"),
          _buildSettingsItem(
            title: "Notifications",
            icon: FontAwesomeIcons.bell,
            onTap: () {
              // Handle tap
            },
          ),
          _buildSettingsItem(
            title: "Email Settings",
            icon: FontAwesomeIcons.envelope,
            onTap: () {
              // Handle tap
            },
          ),
          _buildSettingsItem(
            title: "Manage Addresses",
            icon: FontAwesomeIcons.mapMarkerAlt,
            onTap: () {
              // Handle tap
            },
          ),
          _buildSettingsItem(
            title: "Manage Payment",
            icon: FontAwesomeIcons.creditCard,
            onTap: () {
              // Handle tap
            },
          ),
          _buildSettingsItem(
            title: "Data Control",
            icon: FontAwesomeIcons.trashAlt,
            onTap: () {
              // Handle tap
            },
          ),

          const SizedBox(height: 20),

          // App Settings Section
          _buildSectionTitle("App Settings"),
          _buildToggleSwitch(
            title: "Enable Face ID For Log In",
            value: faceIdEnabled,
            onChanged: (value) {
              setState(() {
                faceIdEnabled = value;
              });
            },
          ),
          _buildToggleSwitch(
            title: "Enable Push Notifications",
            value: pushNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                pushNotificationsEnabled = value;
              });
            },
          ),
          _buildToggleSwitch(
            title: "Dark Mode",
            value: darkModeEnabled,
            onChanged: (value) {
              setState(() {
                darkModeEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // Widget to build section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Widget to build each settings item
  Widget _buildSettingsItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: FaIcon(icon, color: Colors.black87),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  // Widget to build toggle switch item
  Widget _buildToggleSwitch({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        trailing: Switch(
          value: value,
          activeColor: MyColors.primaryColor,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

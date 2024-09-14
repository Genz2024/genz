// File: lib/widgets/me/settings_page.dart

import 'package:flutter/material.dart';
import 'settings/account_security_page.dart'; // Import the Account Security Page
import 'package:genz/login_page.dart'; // Import the Login Page

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildSettingsOption(
                  context,
                  icon: Icons.security,
                  title: 'Account Security',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountSecurityPage()),
                    );
                  },
                ),
                _buildSettingsOption(
                  context,
                  icon: Icons.chat,
                  title: 'Live Chat',
                  onTap: () {
                    // Live Chat পেজে নেভিগেট করতে
                  },
                ),
                _buildSettingsOption(
                  context,
                  icon: Icons.feedback,
                  title: 'Help and Feedback',
                  onTap: () {
                    // Help and Feedback পেজে নেভিগেট করতে
                  },
                ),
                _buildSettingsOption(
                  context,
                  icon: Icons.info,
                  title: 'About Gen-Z',
                  onTap: () {
                    // About Gen-Z পেজে নেভিগেট করতে
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text('Logout', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE871C5), // বোতামের ব্যাকগ্রাউন্ড কালার
                minimumSize: Size(double.infinity, 50), // বোতামের আকার
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // বর্ডার রেডিয়াস
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildSettingsOption(BuildContext context, {required IconData icon, required String title, required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFE871C5)),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: onTap,
    );
  }
}

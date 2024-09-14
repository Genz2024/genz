// File: lib/widgets/me/settings/account_security_page.dart

import 'package:flutter/material.dart';
import 'change_mobile_page.dart'; // Change Mobile পেজ ইম্পোর্ট
import 'change_password_page.dart'; // Change Password পেজ ইম্পোর্ট

class AccountSecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Security', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.phone, color: Color(0xFFE871C5)),
            title: Text('Change Phone Number', style: TextStyle(color: Colors.white, fontSize: 16)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangeMobilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Color(0xFFE871C5)),
            title: Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 16)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

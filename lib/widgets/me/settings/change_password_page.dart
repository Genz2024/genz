// File: lib/widgets/me/settings/change_password_page.dart

import 'package:flutter/material.dart';
import 'setting_verification_page.dart'; // Verification পেজ ইম্পোর্ট

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Old Password',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _oldPassword = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _newPassword = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_newPassword == _confirmPassword) {
                  // এখানে পাসওয়ার্ড পরিবর্তনের লজিক বসাতে হবে
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Change Password'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE871C5),
              ),
            ),
            TextButton(
              onPressed: () {
                _showForgotPasswordDialog(context);
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'To reset your password, get the verification code to complete SMS verification first.',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'About to send verification code to +8801737097733',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingVerificationPage(phoneNumber: '+8801737097733')),
                  );
                },
                child: Text('Get SMS'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE871C5),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}

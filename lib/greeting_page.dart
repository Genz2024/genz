// File: lib/greeting_page.dart

import 'package:flutter/material.dart';

class GreetingPage extends StatelessWidget {
  final String userName;
  final String userImage;

  GreetingPage({required this.userName, required this.userImage});

  @override
  Widget build(BuildContext context) {
    TextEditingController greetingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Send Greeting', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(userImage),
              radius: 40,
            ),
            SizedBox(height: 20),
            Text(
              'Send a Greeting to $userName',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: greetingController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Your Greeting',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Greeting Sent to $userName'),
                ));
              },
              child: Text('Send Greeting'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE871C5),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

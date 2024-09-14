import 'package:flutter/material.dart';

class ReportUser extends StatelessWidget {
  final String userName;

  ReportUser({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Report ${userName} for inappropriate behavior?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Report user logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User reported successfully!')),
                );
              },
              child: Text('Report User'),
            ),
          ],
        ),
      ),
    );
  }
}

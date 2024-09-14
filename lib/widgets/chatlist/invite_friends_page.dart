import 'package:flutter/material.dart';

class InviteFriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Friends"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInviteOption(context, 'Email', 'lib/assets/icons/email.png'),
            _buildInviteOption(context, 'WhatsApp', 'lib/assets/icons/whatsapp.png'),
            _buildInviteOption(context, 'Messenger', 'lib/assets/icons/messenger.png'),
            _buildInviteOption(context, 'Messages', 'lib/assets/icons/messages.png'),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildInviteOption(BuildContext context, String title, String iconPath) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        leading: Image.asset(
          iconPath,
          height: 24,
          width: 24,
        ), // Custom আইকন যুক্ত করা হয়েছে
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invite via $title')),
          );
        },
      ),
    );
  }
}

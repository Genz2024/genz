import 'package:flutter/material.dart';

class BlockUser extends StatefulWidget {
  final String userName;

  BlockUser({required this.userName});

  @override
  _BlockUserState createState() => _BlockUserState();
}

class _BlockUserState extends State<BlockUser> {
  bool isBlocked = false;

  void toggleBlockStatus() {
    setState(() {
      isBlocked = !isBlocked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Block/Unblock User'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isBlocked ? 'You have blocked ${widget.userName}' : 'You have not blocked ${widget.userName}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: toggleBlockStatus,
            child: Text(isBlocked ? 'Unblock User' : 'Block User'),
          ),
        ],
      ),
    );
  }
}

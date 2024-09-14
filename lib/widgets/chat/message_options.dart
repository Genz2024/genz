import 'package:flutter/material.dart';

class MessageOptions extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onForward;
  final VoidCallback onCopy;
  final VoidCallback onReply;

  const MessageOptions({
    required this.onDelete,
    required this.onForward,
    required this.onCopy,
    required this.onReply,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildOption(Icons.reply, "Reply", onReply),
          _buildOption(Icons.copy, "Copy", onCopy),
          _buildOption(Icons.forward, "Forward", onForward),
          _buildOption(Icons.delete, "Delete", onDelete, isDelete: true),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String text, VoidCallback onTap, {bool isDelete = false}) {
    return ListTile(
      leading: Icon(icon, color: isDelete ? Colors.red : Colors.white),
      title: Text(
        text,
        style: TextStyle(color: isDelete ? Colors.red : Colors.white),
      ),
      onTap: onTap,
    );
  }
}

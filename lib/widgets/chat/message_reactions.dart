import 'package:flutter/material.dart';

class MessageReactions extends StatelessWidget {
  final Function(String) onReact;

  MessageReactions({required this.onReact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ReactionEmoji(emoji: "❤️", onReact: onReact),
          ReactionEmoji(emoji: "😂", onReact: onReact),
          ReactionEmoji(emoji: "😮", onReact: onReact),
          ReactionEmoji(emoji: "😢", onReact: onReact),
          ReactionEmoji(emoji: "😡", onReact: onReact),
          ReactionEmoji(emoji: "👍", onReact: onReact),
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // আরো ইমোজি যুক্ত করার জন্য
            },
          ),
        ],
      ),
    );
  }
}

class ReactionEmoji extends StatelessWidget {
  final String emoji;
  final Function(String) onReact;

  ReactionEmoji({required this.emoji, required this.onReact});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onReact(emoji);
        Navigator.pop(context); // ইমোজি ক্লিক করার পরে বটম শীট বন্ধ হবে
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

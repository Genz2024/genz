import 'package:flutter/material.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:genz/widgets/chat/FullScreenImageViewer.dart';
import 'package:genz/widgets/chat/voice_message.dart';
import 'message_options.dart';
import 'package:flutter/services.dart'; // Clipboard ব্যবহারের জন্য

class MessageBubble extends StatefulWidget {
  final String message;
  final bool isMe;
  final DateTime time;
  final String? imageUrl;
  final String? audioUrl;
  final VoidCallback? onPlayAudio;
  final bool isCall;

  MessageBubble({
    required this.message,
    required this.isMe,
    required this.time,
    this.imageUrl,
    this.audioUrl,
    this.onPlayAudio,
    this.isCall = false,
  });

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  Future<void> _saveImage(BuildContext context, String imageUrl) async {
    try {
      final result = await GallerySaver.saveImage(imageUrl);

      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image saved to gallery')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save image: $e')),
      );
    }
  }

  void _showOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: MessageOptions(
            onDelete: () {
              setState(() {
                // Optional deletion logic
              });
              Navigator.of(context).pop();
              print("Delete tapped!");
            },
            onForward: () {
              Navigator.of(context).pop();
              print("Forward tapped!");
              // Forward message logic here
            },
            onCopy: () {
              Clipboard.setData(ClipboardData(text: widget.message));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Message copied to clipboard')),
              );
            },
            onReply: () {
              Navigator.of(context).pop();
              print("Reply tapped!");
              // Reply logic here
            },
          ),
          backgroundColor: Colors.transparent, // Remove white background
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Align(
          alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              if (widget.imageUrl != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImageViewer(imageUrl: widget.imageUrl!),
                  ),
                );
              } else if (widget.audioUrl != null && widget.onPlayAudio != null) {
                widget.onPlayAudio!();
              }
            },
            onLongPress: () {
              _showOptions(context);
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: widget.isMe
                    ? LinearGradient(
                        colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null,
                color: widget.isMe ? null : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isCall)
                    Row(
                      children: [
                        Icon(Icons.call, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.message,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  else if (widget.imageUrl != null)
                    Image.file(File(widget.imageUrl!))
                  else if (widget.audioUrl != null)
                    VoiceMessage(audioUrl: widget.audioUrl!, isMe: widget.isMe, time: widget.time)
                  else
                    Text(
                      widget.message,
                      style: TextStyle(color: Colors.white),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

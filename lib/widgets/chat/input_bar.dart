import 'dart:async';
import 'package:flutter/material.dart';

class InputBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSendPressed;
  final VoidCallback onImagePickPressed;
  final VoidCallback onCameraPressed;
  final VoidCallback onPlusPressed;
  final VoidCallback onStickerPressed;
  final ValueChanged<String> onTextChanged;
  final bool isTyping;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final bool showPlusIcon;

  InputBar({
    required this.controller,
    required this.onSendPressed,
    required this.onImagePickPressed,
    required this.onCameraPressed,
    required this.onPlusPressed,
    required this.onStickerPressed,
    required this.onTextChanged,
    required this.isTyping,
    required this.onStartRecording,
    required this.onStopRecording,
    this.showPlusIcon = false,
  });

  @override
  _InputBarState createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  bool isRecording = false;
  int recordingDuration = 0;
  Timer? _timer;
  bool _isTyping = false; // এই পরিবর্তনটি যোগ করা হয়েছে

  void _startRecording() {
    setState(() {
      isRecording = true;
      recordingDuration = 0;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        recordingDuration++;
      });
    });
    widget.onStartRecording();
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() {
      isRecording = false;
    });
    widget.onStopRecording();
    widget.onSendPressed(); // রেকর্ড শেষ হলে স্বয়ংক্রিয়ভাবে প্রেরণ করা হবে
  }

  void _sendMessage() {
    if (_isTyping) {
      widget.onSendPressed(); // টেক্সট থাকলে প্রেরণ করা হচ্ছে
      widget.controller.clear(); // টেক্সট ফিল্ড ক্লিয়ার হচ্ছে
      setState(() {
        _isTyping = false; // প্রেরণের পরে টাইপিং ফ্ল্যাগ ফালস করা হচ্ছে
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: <Widget>[
          if (widget.showPlusIcon)
            IconButton(
              icon: Image.asset(
                'lib/assets/icons/plus_icon.png',
                height: 24,
                width: 24,
              ),
              color: Colors.white,
              onPressed: widget.onPlusPressed,
            ),
          IconButton(
            icon: Image.asset(
              'lib/assets/icons/camera_icon.png',
              height: 24,
              width: 24,
            ),
            color: Colors.white,
            onPressed: widget.onCameraPressed,
          ),
          IconButton(
            icon: Image.asset(
              'lib/assets/icons/image_icon.png',
              height: 24,
              width: 24,
            ),
            color: Colors.white,
            onPressed: widget.onImagePickPressed,
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 100,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        controller: widget.controller,
                        minLines: 1,
                        maxLines: 4,
                        onChanged: (text) {
                          widget.onTextChanged(text);
                          setState(() {
                            _isTyping = text.isNotEmpty; // টাইপিং ফ্ল্যাগ আপডেট করা হয়েছে
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.grey[300]),
                        keyboardType: TextInputType.multiline,
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      'lib/assets/icons/sticker.png',
                      height: 15,
                      width: 15,
                    ),
                    onPressed: widget.onStickerPressed,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage, // এখানে ক্লিক করলেই বার্তা প্রেরণ হবে
            onLongPressStart: (_) => _startRecording(),
            onLongPressEnd: (_) => _stopRecording(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: Icon(
                  _isTyping ? Icons.send : Icons.mic, // পাঠানোর সময় পাঠানোর আইকন দেখানো হবে
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (isRecording)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "$recordingDuration s",
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

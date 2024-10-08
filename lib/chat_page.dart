import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'widgets/chat/message_bubble.dart';
import 'widgets/chat/input_bar.dart';
import 'widgets/chat/voice_recorder.dart';
import 'widgets/chat/audio_call.dart';
import 'widgets/chat/video_call.dart';
import 'widgets/chat/typing_indicator.dart';
import 'widgets/chat/profile_view.dart'; // Corrected import path
import 'widgets/chat/block_user.dart';   // Corrected import path
import 'widgets/chat/report_user.dart';  // Corrected import path
import 'user_profile_page.dart'; // User Profile page import

class ChatPage extends StatefulWidget {
  final String userName;
  final String profileImage;
  final DateTime lastActive;

  ChatPage({
    required this.userName,
    required this.profileImage,
    required this.lastActive,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  bool _isOtherUserTyping = false;
  VoiceRecorder _voiceRecorder = VoiceRecorder();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.insert(0, {
        'message': _controller.text,
        'time': DateTime.now(),
        'isMe': true,
      });
      _isTyping = false;
    });
    _controller.clear();
  }

  void _sendImage(String imageUrl) {
    setState(() {
      _messages.insert(0, {
        'imageUrl': imageUrl,
        'time': DateTime.now(),
        'isMe': true,
      });
    });
  }

  void _sendAudio(String audioUrl) {
    setState(() {
      _messages.insert(0, {
        'audioUrl': audioUrl,
        'time': DateTime.now(),
        'isMe': true,
      });
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _sendImage(pickedFile.path);
    }
  }

  Future<void> _pickCameraImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _sendImage(pickedFile.path);
    }
  }

  void _onTextChanged(String text) {
    setState(() {
      _isTyping = text.isNotEmpty;
    });

    if (_isTyping) {
      _sendTypingIndicatorToOtherUser();
    }
  }

  void _sendTypingIndicatorToOtherUser() {
    if (!_isTyping) {
      setState(() {
        _isOtherUserTyping = true;
      });

      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isOtherUserTyping = false;
          });
        }
      });
    }
  }

  void _startRecording() async {
    await _voiceRecorder.startRecording();
  }

  void _stopRecording() async {
    final path = await _voiceRecorder.stopRecording();
    if (path != null) {
      _sendAudio(path);
    }
  }

  void _makeAudioCall() {
    final startTime = DateTime.now();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudioCallScreen(
          onCallEnd: () {
            _callEnded(startTime, DateTime.now());
          },
          onMissedCall: _missedCall,
        ),
      ),
    );
  }

  void _makeVideoCall() {
    final startTime = DateTime.now();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallScreen(
          onCallEnd: () {
            _callEnded(startTime, DateTime.now());
          },
          onMissedCall: _missedCall,
        ),
      ),
    );
  }

  void _callEnded(DateTime startTime, DateTime endTime) {
    final duration = endTime.difference(startTime);
    setState(() {
      _messages.insert(0, {
        'message': 'Call ended, duration: ${_formatDuration(duration)}',
        'time': DateTime.now(),
        'isMe': true,
        'isCall': true,
      });
    });
  }

  void _missedCall() {
    setState(() {
      _messages.insert(0, {
        'message': 'Missed call',
        'time': DateTime.now(),
        'isMe': true,
        'isCall': true,
      });
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inHours > 0 ? '${duration.inHours}h ' : ''}${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }

  String _getLastActiveText() {
    final now = DateTime.now();
    final difference = now.difference(widget.lastActive);

    if (difference.inMinutes < 1) {
      return "Active now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays <= 3) {
      return "${difference.inDays} days ago";
    } else {
      return "Long time ago";
    }
  }

  String _getFormattedDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else {
      return DateFormat('d MMM').format(date);
    }
  }

  void _showDropUpMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF9872EB).withOpacity(0.4),
                offset: Offset(-6.0, -6.0),
                blurRadius: 16.0,
              ),
              BoxShadow(
                color: Color(0xFFE871C5).withOpacity(0.4),
                offset: Offset(6.0, 6.0),
                blurRadius: 16.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("lib/assets/icons/sendmoney_icon.png"),
                ),
                title: Text('Send Money', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  print('Send Money tapped');
                },
              ),
              ListTile(
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("lib/assets/icons/icebreakers_icon.png"),
                ),
                title: Text('Icebreaker', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  print('Icebreaker tapped');
                },
              ),
              ListTile(
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("lib/assets/icons/locations_icon.png"),
                ),
                title: Text('Location', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  print('Location tapped');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.profileImage),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    _getLastActiveText(),
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Image.asset('lib/assets/icons/audio_call_icon.png', width: 20, height: 20),
            onPressed: _makeAudioCall,
          ),
          IconButton(
            icon: Image.asset('lib/assets/icons/video_call_icon.png', width: 24, height: 24),
            onPressed: _makeVideoCall,
          ),
          IconButton(
            icon: Image.asset('lib/assets/icons/more_icon.png', width: 24, height: 24),
            onPressed: () {
              _showMenuOptions(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0 && _isOtherUserTyping) {
                    return TypingIndicator(isTyping: true);
                  }

                  final messageIndex = index - 1;

                  if (messageIndex >= 0 && messageIndex < _messages.length) {
                    bool showDate = false;

                    if (messageIndex == _messages.length - 1 ||
                        _messages[messageIndex]['time'].day != _messages[messageIndex + 1]['time'].day) {
                      showDate = true;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showDate)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Center(
                              child: Text(
                                _getFormattedDate(_messages[messageIndex]['time']),
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                          ),
                        MessageBubble(
                          message: _messages[messageIndex]['message'] ?? '',
                          isMe: _messages[messageIndex]['isMe'],
                          time: _messages[messageIndex]['time'],
                          imageUrl: _messages[messageIndex]['imageUrl'],
                          audioUrl: _messages[messageIndex]['audioUrl'],
                          isCall: _messages[messageIndex]['isCall'] ?? false,
                          onPlayAudio: () {
                            print('Playing audio from: ${_messages[messageIndex]['audioUrl']}');
                          },
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
            InputBar(
              controller: _controller,
              onSendPressed: _sendMessage,
              onImagePickPressed: _pickImage,
              onCameraPressed: _pickCameraImage,
              onPlusPressed: () {
                _showDropUpMenu(context);
              },
              onStickerPressed: () {
                print("Sticker icon pressed");
              },
              onTextChanged: _onTextChanged,
              isTyping: _isTyping,
              onStartRecording: _startRecording,
              onStopRecording: _stopRecording,
              showPlusIcon: true,
            ),
          ],
        ),
      ),
    );
  }

  void _showMenuOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('View Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(
                      name: widget.userName,
                      bio: 'User bio here',
                      study: 'Study information here',
                      dob: 'Date of Birth',
                      status: 'User status here',
                      relationshipStatus: 'Relationship status here',
                      workAt: 'Some Company',
                      workPosition: 'Software Engineer', // Added workPosition
                      religion: 'Religion', // Added religion
                      language: 'English', // Added language
                      gender: 'Gender', // Added gender
                      image: widget.profileImage,
                      cover: 'assets/images/cover_image.png',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.block),
              title: Text('Block User'),
              onTap: () {
                Navigator.pushNamed(context, '/block_user');
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text('Report User'),
              onTap: () {
                Navigator.pushNamed(context, '/report_user');
              },
            ),
          ],
        );
      },
    );
  }
}

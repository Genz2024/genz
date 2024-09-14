import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget {
  final VoidCallback onCallEnd;
  final VoidCallback onMissedCall;
  bool showMissedCallButton = false;

  VideoCallScreen({required this.onCallEnd, required this.onMissedCall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Video Call'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Placeholder representing the video feed area
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  'Video Feed Here',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.white),
                  onPressed: () {
                    // Toggle mute logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call_end, color: Colors.red),
                  onPressed: () {
                    onCallEnd(); // Call ended logic
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.videocam, color: Colors.white),
                  onPressed: () {
                    // Toggle camera logic
                  },
                ),
              ],
            ),
          ),
          if (showMissedCallButton) // Show button only when missed call is triggered
            Positioned(
              top: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  showMissedCallButton = true;
                  onMissedCall(); // Missed call logic
                },
                child: Text('Missed Call'),
              ),
            ),
        ],
      ),
    );
  }
}

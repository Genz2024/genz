import 'package:flutter/material.dart';

class AudioCallScreen extends StatelessWidget {
  final VoidCallback onCallEnd;
  final VoidCallback onMissedCall;
  bool showMissedCallButton = false;

  AudioCallScreen({required this.onCallEnd, required this.onMissedCall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Audio Call'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile1.jpg'), // Your profile image path
            ),
            SizedBox(height: 20),
            Text(
              'Calling...',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.white),
                  onPressed: () {
                    // Mute logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call_end, color: Colors.red),
                  onPressed: () {
                    onCallEnd(); // Call end logic
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.volume_up, color: Colors.white),
                  onPressed: () {
                    // Speaker toggle logic
                  },
                ),
              ],
            ),
            if (showMissedCallButton) // Show button only when missed call is triggered
              ElevatedButton(
                onPressed: () {
                  showMissedCallButton = true;
                  onMissedCall(); // Missed call logic
                },
                child: Text('Missed Call'),
              ),
          ],
        ),
      ),
    );
  }
}

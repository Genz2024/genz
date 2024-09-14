import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:intl/intl.dart';

class VoiceMessage extends StatefulWidget {
  final String audioUrl;
  final bool isMe;
  final DateTime time;

  VoiceMessage({
    required this.audioUrl,
    required this.isMe,
    required this.time,
  });

  @override
  _VoiceMessageState createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;
  late Duration _duration = Duration.zero;
  late Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration ?? Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.setUrl(widget.audioUrl);
      await _audioPlayer.setSpeed(_playbackSpeed);
      await _audioPlayer.play();
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _changePlaybackSpeed() {
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        _playbackSpeed = 2.0;
      } else {
        _playbackSpeed = 1.0;
      }
      _audioPlayer.setSpeed(_playbackSpeed);
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5, // সর্বাধিক প্রস্থ স্ক্রিনের 50% করা হয়েছে
          ),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4), // Padding আরও ছোট করা হয়েছে
          margin: EdgeInsets.symmetric(vertical: 1, horizontal: 5), // margin আরও ছোট করা হয়েছে
          decoration: BoxDecoration(
            gradient: widget.isMe
                ? LinearGradient(
                    colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: widget.isMe ? null : Colors.grey[300],
            borderRadius: BorderRadius.circular(10), // বুদবুদের কোণ আরও ছোট করা হয়েছে
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Content অনুযায়ী box এর আকার হবে
            children: [
              GestureDetector(
                onTap: _togglePlayPause,
                child: Icon(
                  _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: Colors.white,
                  size: 14, // আইকনের সাইজ ছোট করা হয়েছে
                ),
              ),
              SizedBox(width: 4),
              GestureDetector(
                onTap: _changePlaybackSpeed,
                child: Text(
                  "${_playbackSpeed.toStringAsFixed(1)}x",
                  style: TextStyle(color: Colors.white, fontSize: 9), // Font Size আরও ছোট করা হয়েছে
                ),
              ),
              SizedBox(width: 6),
              Text(
                _isPlaying
                    ? _formatDuration(_duration - _position)
                    : DateFormat('HH:mm').format(widget.time),
                style: TextStyle(color: Colors.white, fontSize: 9), // Font Size আরও ছোট করা হয়েছে
              ),
            ],
          ),
        ),
      ],
    );
  }
}

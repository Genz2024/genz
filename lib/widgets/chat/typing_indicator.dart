import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  final bool isTyping;

  TypingIndicator({required this.isTyping});

  @override
  Widget build(BuildContext context) {
    return isTyping
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Text(
                  "Typing...",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(width: 5),
                AnimatedDots(),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}

class AnimatedDots extends StatefulWidget {
  @override
  _AnimatedDotsState createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return FadeTransition(
          opacity: _animation!,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              ".",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }),
    );
  }
}

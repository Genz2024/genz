import 'package:flutter/material.dart';

class GlitchEffect extends StatefulWidget {
  final Widget child;

  GlitchEffect({required this.child});

  @override
  _GlitchEffectState createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -3.0, end: 3.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: widget.child,
        );
      },
    );
  }
}

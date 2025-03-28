import 'package:flutter/material.dart';

/**
 * 文渐入渐出效果,跟准确来讲是,文本位移动画加渐入渐出动画
 */

enum AniProps { opacity, translateX, translateY, scale }

class FadeAnimation extends StatefulWidget {
  final double delay;
  final Widget child;
  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  // late Animation<Offset> _translateAnimation;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      _controller.forward();
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInCubic),
    );
    // _translateAnimation = Tween<Offset>(begin: Offset(0, -5), end: Offset(0, 0))
    // .animate(
    // CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    // _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: widget.child,
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation({
    super.key,
    required this.animationController,
    required this.loginChild,
    required this.signChild,
  });

  final AnimationController animationController;

  final Widget loginChild;
  final Widget signChild;
  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return flipAnimation();
  }

  Widget flipAnimation() {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateY(widget.animationController.value * pi),
            child: widget.animationController.value < 0.5
                ? widget.loginChild // 前半段显示前面的卡片
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: widget.signChild),
          );
        });
  }
}

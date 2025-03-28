import 'dart:math';
import 'package:flutter/material.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation({
    Key? key,
    required this.controller,
    required this.frontChild,
    required this.backChild,
  }) : super(key: key);
  final AnimationController controller;

  /// 前面的子组件
  final Widget frontChild;

  /// 后面的子组件
  final Widget backChild;

  /// 动画持续时间

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    _animation = Tween<double>(begin: 0, end: pi).animate(widget.controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final isUnder = _animation.value >= (pi / 2);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateX(_animation.value),
          child: isUnder ? widget.backChild : widget.frontChild,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notepad/animations/interlate_animation.dart';
import 'package:notepad/page/login/widget/back_child.dart';
import 'package:notepad/page/login/widget/front_child.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(period: Duration(seconds: 2));
    super.initState();
  }

  @override
/*************  ✨ Codeium Command ⭐  *************/
/******  ca30c04c-783e-4eda-90f8-03d2ccdddde0  *******/ /// Builds the UI for the login screen.
  Widget build(BuildContext context) {
    return Material(
        child: Align(
      alignment: Alignment.center,
      child: InterlateAnimation(
        fontChild: FrontChild(),
        backChild: BackChild(),
      ),
    ));
  }
}

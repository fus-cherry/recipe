import 'package:flutter/material.dart';
import 'package:notepad/animations/flip_animation.dart';
import 'package:notepad/page/login/widget/signin_child.dart';
import 'package:notepad/page/login/widget/login_child.dart';

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
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Align(
      alignment: Alignment.center,
      // child: FrontChild(animationController: _animationController)
      child: FlipAnimation(
        animationController: _animationController,
        loginChild: FrontChild(
          animationController: _animationController,
        ),
        signChild: BackChild(
          animationController: _animationController,
        ),
      ),
    ));
  }
}

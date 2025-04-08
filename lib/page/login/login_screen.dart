import 'package:flutter/material.dart';
import 'package:notepad/animations/flip_animation.dart';
import 'package:notepad/components/show_dialog.dart';
import 'package:notepad/page/login/widget/signin_child.dart';
import 'package:notepad/page/login/widget/login_child.dart';
import 'package:notepad/utils/extension.dart';

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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 16.0),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/login_background.png"),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 48.0, left: 16.0),
                child: Text(
                  "Welcome to Notepad",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                ).fadeAnimation(0.2),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: FlipAnimation(
                animationController: _animationController,
                loginChild: FrontChild(
                  animationController: _animationController,
                ),
                signChild: BackChild(
                  animationController: _animationController,
                ),
              ),
            ),
            _buildStatement(context),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatement(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 48.0, right: 16.0),
        child: Text(
          "Build By Fus-Cherry , 2025.3.31",
          style: Theme.of(context).textTheme.bodyLarge,
        ).fadeAnimation(0.2),
      ),
    );
  }
}

Widget _buildButton(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.green.shade200),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      onPressed: () {
        ConfirmDialogComponent().showDialogComponent(context,
            title: "提示",
            content: "是否退出登录",
            confirmText: "确认",
            cancelText: "取消");
      },
      child: Text(
        "点击",
        style: Theme.of(context).textTheme.bodyLarge,
      ).fadeAnimation(0.2),
    ),
  );
}

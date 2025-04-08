import 'package:flutter/material.dart';
import 'package:notepad/components/text_input.dart';

class BackChild extends StatefulWidget {
  const BackChild({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  State<BackChild> createState() => _BackChildState();
}

class _BackChildState extends State<BackChild> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '注册',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.blue.shade50),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          TextInputComponents(
            controller: _usernameController,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TextInputComponents(
            controller: _passwordController,
          ),
          SizedBox(height: 24.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(Colors.green.shade200),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            onPressed: () {
              widget.animationController.reverse();
            },
            child: Text(
              '注册',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/blocs/login_blocs/login_bloc.dart';
import 'package:notepad/components/text_input.dart';

class BackChild extends StatefulWidget {
  const BackChild({super.key});

  @override
  State<BackChild> createState() => _BackChildState();
}

class _BackChildState extends State<BackChild> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '注册',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            TextInputComponents(
              controller: _usernameController,
            ),
            SizedBox(height: 16.0),
            TextInputComponents(
              controller: _passwordController,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(LoginInitial());
              },
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}

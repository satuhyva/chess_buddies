import 'package:flutter/material.dart';

class ChangeLoginSignup extends StatelessWidget {
  final bool isLoginMode;
  final Function changeLoginMode;
  ChangeLoginSignup({required this.isLoginMode, required this.changeLoginMode});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(
            isLoginMode ? 'Create new account' : 'Login to existing account',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        onPressed: () => changeLoginMode());
  }
}

import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  final bool isLoginMode;

  FormTitle({required this.isLoginMode});

  @override
  Widget build(BuildContext context) {
    return Text(isLoginMode ? 'CHESS BUDDIES LOGIN' : 'CHESS BUDDIES SIGN UP',
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor));
  }
}

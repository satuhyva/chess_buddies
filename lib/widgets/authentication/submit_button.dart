import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoginMode;
  final Function submit;
  SubmitButton({required this.isLoginMode, required this.submit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ElevatedButton(
        child: Text(isLoginMode ? 'Login' : 'Sign up',
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
        onPressed: () => submit(),
      ),
    );
  }
}

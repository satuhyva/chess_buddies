import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final Function onSavedData;
  PasswordInput({required this.onSavedData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: const ValueKey('userPassword'),
        obscureText: true,
        decoration: const InputDecoration(
            labelText: 'Password', labelStyle: TextStyle(fontSize: 14)),
        onSaved: (value) => onSavedData(value),
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 8) {
            return 'Please edit! Password must be at least 8 characters long.';
          }
          return null;
        });
  }
}

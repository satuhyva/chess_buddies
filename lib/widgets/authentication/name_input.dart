import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  final Function onSavedData;
  NameInput({required this.onSavedData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: const ValueKey('userName'),
        decoration: const InputDecoration(
            labelText: 'Your name in the Chess Buddies app',
            labelStyle: TextStyle(fontSize: 14)),
        onSaved: (value) => onSavedData(value),
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 3) {
            return 'Please edit! Name must be at least 3 characters long.';
          }
          return null;
        });
  }
}

import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  final Function onSavedData;
  EmailInput({required this.onSavedData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: const ValueKey('userEmail'),
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            labelText: 'Email address', labelStyle: TextStyle(fontSize: 14)),
        onSaved: (value) => onSavedData(value),
        validator: (value) {
          RegExp regularExpression = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
          if (value == null ||
              value.isEmpty ||
              value.length < 3 ||
              !regularExpression.hasMatch(value)) {
            return 'Please enter a valid email address!';
          }
          return null;
        });
  }
}

import 'package:flutter/material.dart';

class GeneralTitle extends StatelessWidget {
  final title_text;
  GeneralTitle({required this.title_text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Text(title_text,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor)));
  }
}

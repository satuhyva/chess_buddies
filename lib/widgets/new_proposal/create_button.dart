import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final Function submit;
  CreateButton({required this.submit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: ElevatedButton(
        child: Text('Create',
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
        onPressed: () => submit(),
      ),
    );
  }
}

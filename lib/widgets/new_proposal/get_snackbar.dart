import 'package:flutter/material.dart';

SnackBar getSnackbar(BuildContext context, String proposalId) {
  final errorMessage = proposalId == ''
      ? '\nERROR:\n\nCould not create proposal.\nPlease try again!'
      : 'SUCCESS:\n\nNew proposal successfully created!';

  return SnackBar(
    content: Container(
      height: 130,
      color: Colors.black,
      child: Text(errorMessage,
          style: TextStyle(
              color: proposalId == ''
                  ? Theme.of(context).errorColor
                  : Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18)),
    ),
    backgroundColor: Colors.black,
    duration: const Duration(seconds: 4),
  );
}

import 'package:flutter/material.dart';

SnackBar getSnackbar(BuildContext context, String errorType) {
  final errorMessage = errorType == 'userNameExists'
      ? '\nERROR:\n\nThe name you selected is already in use.\nPlease select another name!'
      : errorType == 'emailExists'
          ? '\nERROR:\n\nThe email you selected is already in use.\nPlease select another email!'
          : '\nERROR:\n\nSome error occurred.\nPlease check your credentials!';

  return SnackBar(
    content: Container(
      height: 130,
      color: Colors.black,
      child: Text(errorMessage,
          style: TextStyle(
              color: Theme.of(context).errorColor,
              fontWeight: FontWeight.bold,
              fontSize: 18)),
    ),
    backgroundColor: Colors.black,
    duration: Duration(seconds: 6),
  );
}

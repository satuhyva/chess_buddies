import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> tryToInitialiseWithOldCredentials(Function hideAuthenticationForm,
    BuildContext context, Function hideLoadingSpinner) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.containsKey('NAME_IN_CHESSBUDDIES') &&
      preferences.containsKey('LEVEL_IN_CHESSBUDDIES') &&
      preferences.containsKey('PASSWORD_IN_CHESSBUDDIES') &&
      preferences.containsKey('EMAIL_IN_CHESSBUDDIES')) {
    final email = preferences.getString('EMAIL_IN_CHESSBUDDIES') ?? '';
    final password = preferences.getString('PASSWORD_IN_CHESSBUDDIES') ?? '';
    await Firebase.initializeApp();
    final firebaseAuthorization = FirebaseAuth.instance;
    try {
      await firebaseAuthorization.signInWithEmailAndPassword(
          email: email, password: password);
      hideAuthenticationForm();
    } catch (error) {
      hideLoadingSpinner();
    }
  } else {
    hideLoadingSpinner();
  }
}

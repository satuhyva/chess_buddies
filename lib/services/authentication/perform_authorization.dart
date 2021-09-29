import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './name_already_exists.dart';
import './set_credentials_to_shared_prefrences.dart';
import '../../widgets/authentication/get_snackbar.dart';
import './create_new_user.dart';

Future<void> performAuthorization(
    BuildContext context,
    Function hideAuthenticationForm,
    String userName,
    String userEmail,
    String userPassword,
    String userLevel,
    bool isLoginMode) async {
  await Firebase.initializeApp();
  if (await nameAlreadyExists(userName)) {
    ScaffoldMessenger.of(context)
        .showSnackBar(getSnackbar(context, 'userNameExists'));
    return;
  }
  final firebaseAuthorization = FirebaseAuth.instance;
  dynamic response;
  try {
    if (isLoginMode) {
      response = await firebaseAuthorization.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } else {
      response = await firebaseAuthorization.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
    }
    if (response != null && response.user != null) {
      final userUid = response.user.uid;
      if (!isLoginMode) {
        await createNewUser(userName, userEmail, userUid, userLevel);
      }
      setCredentialsToSharedPreferences(
          userName, userLevel, userPassword, userEmail);
      hideAuthenticationForm();
    } else {
      throw Error();
    }
  } on FirebaseAuthException catch (error) {
    if ((error.message as String).contains('email address is already in use')) {
      ScaffoldMessenger.of(context)
          .showSnackBar(getSnackbar(context, 'emailExists'));
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(getSnackbar(context, 'default'));
  }
}

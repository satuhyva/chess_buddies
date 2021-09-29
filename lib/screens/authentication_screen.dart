import 'package:flutter/material.dart';

import '../widgets/authentication/authentication_form.dart';
import '../services/authentication/perform_authorization.dart';
import '../services/authentication/try_to_initialise_with_old_credentials.dart';
import '../widgets/loading_spinner/loading_spinner.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  AuthenticationScreenState createState() => AuthenticationScreenState();
}

class AuthenticationScreenState extends State {
  var showLoadingSpinner = true;
  void hideLoadingSpinner() {
    setState(() => showLoadingSpinner = false);
  }

  void hideAuthenticationForm() {
    Navigator.of(context).pushReplacementNamed('/my_games');
  }

  void submitFirebaseAuthentication(String userName, String userEmail,
      String userPassword, String userLevel, bool isLoginMode) async {
    await performAuthorization(context, hideAuthenticationForm, userName,
        userEmail, userPassword, userLevel, isLoginMode);
  }

  @override
  void initState() {
    super.initState();
    tryToInitialiseWithOldCredentials(
        hideAuthenticationForm, context, hideLoadingSpinner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: showLoadingSpinner
            ? LoadingSpinner(
                backgroundColor: Theme.of(context).primaryColor,
                ballColor: Theme.of(context).primaryColorLight)
            : AuthorizationForm(
                submitFirebaseAuthentication: submitFirebaseAuthentication,
              ));
  }
}

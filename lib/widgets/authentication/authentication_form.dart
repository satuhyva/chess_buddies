import 'package:flutter/material.dart';

import './name_input.dart';
import './submit_button.dart';
import './change_login_signup.dart';
import './email_input.dart';
import './password_input.dart';
import './skill_level_selection.dart';
import './form_title.dart';

class AuthorizationForm extends StatefulWidget {
  final Function submitFirebaseAuthentication;
  const AuthorizationForm(
      {Key? key, required this.submitFirebaseAuthentication})
      : super(key: key);

  @override
  _AuthorizationFormState createState() => _AuthorizationFormState();
}

class _AuthorizationFormState extends State<AuthorizationForm> {
  final formKey = GlobalKey<FormState>();
  var isLoginMode = false;
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String userLevel = 'Beginner';

  void submit() {
    final formInputIsValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (formInputIsValid && userLevel != '') {
      formKey.currentState!.save();
    }
    widget.submitFirebaseAuthentication(
        userName, userEmail, userPassword, userLevel, isLoginMode);
  }

  void changeSelectedLevel(String newLevel) {
    setState(() {
      userLevel = newLevel;
    });
  }

  void saveUsername(name) {
    userName = name;
  }

  void saveEmail(email) {
    userEmail = email;
  }

  void savePassword(password) {
    userPassword = password;
  }

  void changeLoginMode() {
    setState(() {
      isLoginMode = !isLoginMode;
    });
  }

  getFormComponents() {
    if (!isLoginMode) {
      return [
        FormTitle(isLoginMode: isLoginMode),
        NameInput(onSavedData: saveUsername),
        EmailInput(onSavedData: saveEmail),
        PasswordInput(onSavedData: savePassword),
        SkillLevelSelection(
            changeSelectedLevel: changeSelectedLevel, userLevel: userLevel),
        SubmitButton(isLoginMode: isLoginMode, submit: submit),
        ChangeLoginSignup(
            isLoginMode: isLoginMode, changeLoginMode: changeLoginMode)
      ];
    }
    return [
      FormTitle(isLoginMode: isLoginMode),
      EmailInput(onSavedData: saveEmail),
      PasswordInput(onSavedData: savePassword),
      SubmitButton(isLoginMode: isLoginMode, submit: submit),
      ChangeLoginSignup(
          isLoginMode: isLoginMode, changeLoginMode: changeLoginMode)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
          margin:
              const EdgeInsets.only(top: 40, bottom: 0, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 0, left: 20, right: 20),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: getFormComponents()),
              ),
            ),
          )),
    ]);
  }
}

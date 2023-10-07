// @dart=2.9
//import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:speso_chat_app/screens/chat_screen.dart';
import 'package:speso_chat_app/utils/alert_dialogs.dart';
import 'package:validators/validators.dart';


part 'login_store.g.dart';

class LoginStore extends _LoginStore with _$LoginStore {}

abstract class _LoginStore with Store {
  final LoginErrorStore error = LoginErrorStore();
  var localAuth = LocalAuthentication();

  @observable
  bool loading = false;

  @observable
  bool passwordVisible = true;

  @observable
  final _auth = FirebaseAuth.instance;

  @observable
  String email;

  @observable
  bool proceedButtonActive = false;

  @observable
  String password = '';

  @action
  void load(bool load) {
    this.loading = load;
  }

  @action
  void validatePassword(String value) {
    error.password =
    isNull(value) || value.isEmpty ? 'Password is required' : null;
  }

  @action
  void validateEmail(String value) {
    if (isNull(value) || value.isEmpty)
      error.email = 'Email is required';
    else if (!isEmail(value))
      error.email = 'Enter a valid email';
    else
      error.email = null;
  }

   List<ReactionDisposer> _disposers;

   setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword)
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  bool get hasErrors {
    validateEmail(email);
    validatePassword(password);

    return error.hasErrors;
  }

  Future<void> submit(BuildContext context,) async {
    if (hasErrors) return;

    load(true);
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: email, password: password);
          if(credential.user.email==null){
            showCustomDialog(context, "Notification", "User does not exist");
            return;
          }

          var user = credential.user;
          if(user!=null){
            Navigator.pushNamed(context, ChatScreen.routeName);
          }else{
            showCustomDialog(context, "Notification", "User does not exist");
            return;
          }

        } on FirebaseAuthException catch (e) {
          if(e.code == "user-not-found"){
            showCustomDialog(context, "Notification", "User does not exist");

          }else if(e.code == "wrong-password"){
            showCustomDialog(context, "Notification", "wrong password provided for that user");

          }else if(e.code == "invalid-email"){
            showCustomDialog(context, "Notification",  "Your email address format is wrong");
          }else{
            showCustomDialog(context, "Notification", "Incorrect username or password.");
          }
        }
    catch (e) {
      print(e.toString());
    }
        load(false);
  }

}

class LoginErrorStore = _LoginErrorStore with _$LoginErrorStore;

abstract class _LoginErrorStore with Store {
  @observable
  String email;

  @observable
   String password ='';

  @computed
  bool get hasErrors => email != null || password != null;
}
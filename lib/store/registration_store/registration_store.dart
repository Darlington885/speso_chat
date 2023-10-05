import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:speso_chat_app/screens/registration_screen.dart';
import 'package:validators/validators.dart';

import '../../constants/image_assets.dart';
import '../../constants/text_string.dart';
import '../../screens/login_screen.dart';
import '../../utils/alert_dialogs.dart';

part 'registration_store.g.dart';
class RegisterStore extends _RegisterStore with _$RegisterStore {}

abstract class _RegisterStore with Store {
  final RegisterErrorStore error = RegisterErrorStore();
  var localAuth = LocalAuthentication();

  @observable
  bool loading = false;

  @observable
  bool passwordVisible = true;

  @observable
  bool passwordVisibleTwo = true;

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
  void validateEmail(String value) {
    if (isNull(value) || value.isEmpty)
      error.email = 'Email is required';
    else if (!isEmail(value))
      error.email = 'Enter a valid email';
    else
      error.email = null;
  }

  @action
  void validatePassword(String value) {
    error.password =
    isNull(value) || value.isEmpty ? 'Password is required' : null;
  }


  @action
  void validateConfirmPassword(String value) {
    error.password =
    isNull(value) || value.isEmpty ? 'Confirm Password is required' : null;
  }



  List<ReactionDisposer> _disposers;

  void setupValidations() {
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

  Future<void> submit(BuildContext context) async {
    if (hasErrors) return;

   load(true);

    try{
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if(newUser != null){
        openDialog(
            CustomPopupDialog(
              title: regSuccess,
              description: regSuccessDesc,
              buttonText: "Continue",
              img: assetImageThumbs,
              onButtonPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
            ),
            context);
      }
     load(false);
    }
    catch(e){
      print(e);
    }
  }



}

class RegisterErrorStore = _RegisterErrorStore with _$RegisterErrorStore;

abstract class _RegisterErrorStore with Store {
  @observable
  String email;

  @observable
  String password;

  @observable
  String confirmPassword;

  @computed
  bool get hasErrors => email != null || password != null || confirmPassword != null;
}
// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speso_chat_app/constants/colors.dart';
import 'package:speso_chat_app/constants/fonts.dart';
import 'package:speso_chat_app/screens/login_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:speso_chat_app/store/registration_store/registration_store.dart';
import 'package:speso_chat_app/widgets/button.dart';

import '../constants/image_assets.dart';
import '../constants/text_string.dart';
import '../constants/text_style.dart';
import '../utils/alert_dialogs.dart';
import '../widgets/input_field.dart';

var registerStore = RegisterStore();
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);
  static const routeName = '/register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    registerStore.setupValidations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                top: 80.0, left: 24.0, right: 24.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create a",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppFonts.Cabin),
                ),

                Row(
                  children: const [
                    Text(
                      'Speso',
                      style: TextStyle(
                          color: AppColors.blueColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.Cabin),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'account',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.Cabin),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                decoration:kDecorationStyle.copyWith(
                  border: Border.all(color: AppColors.greyColor),
                ),
                child: ListView(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 60),
                  children: [


                    Text(
                      'Email address',
                      style: kSmallTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Observer(
                      builder: (_) => InputField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        hint: "Email address",
                        onChanged: (text) {
                          registerStore.email = text.toLowerCase();
                          // if (text.contains("@") &&
                          //     passwordController.text.length > 3) {
                          //   registerStore.proceedButtonActive = true;
                          // } else {
                          //   registerStore.proceedButtonActive = false;
                          // }
                        },
                        message: registerStore.error.email,
                        error: registerStore.error.email != null,
                        color: AppColors.blackColor,
                        hintColor: AppColors.greyColor,
                        textColor: AppColors.blackColor,
                        focusedColor: AppColors.borderColor,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),


                    Text(
                      'Password',
                      style: kSmallTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Observer(
                      builder: (_) => InputField(
                        controller: passwordController,
                        type: TextInputType.text,
                        hint: 'Password',
                        obscureText: registerStore.passwordVisible,
                        onChanged: (text) {
                          registerStore.password = text;
                        },
                        suffixIcon: GestureDetector(
                            onTap:() =>  registerStore.passwordVisible = !registerStore.passwordVisible,
                            child: IconButton(
                              icon: registerStore.passwordVisible
                                  ? Image.asset(
                                assetEyeClosed,
                                height: 10.0,
                                width: 14.67,
                              )
                                  : Image.asset(
                                assetEyeOpen,
                                height: 10.0,
                                width: 14.67,
                              ),
                            )),
                        message: registerStore.error.password,
                        error: registerStore.error.password != null,
                        color: AppColors.blackColor,
                        hintColor: AppColors.greyColor,
                        textColor: AppColors.blackColor,
                        focusedColor: AppColors.borderColor,
                      ),
                    ),


                    SizedBox(
                      height: 80.0,
                    ),
                    Observer(
                      builder: (ctx) => Container(
                        width: double.infinity,
                        child: Button(

                          text: 'Submit',
                          onPressed:
                          //registerStore.proceedButtonActive ?
                              () {
                            FocusScope.of(context).unfocus();

                            if (registerStore.hasErrors) {
                            }  else if (emailController.text == null || emailController.text == " ") {
                              registerStore.error.email =
                              "Please enter your Password";
                            }  else if (passwordController.text == null ||
                                passwordController.text == " " ) {
                              registerStore.error.password = "Please enter your Password";
                            }   else {
                              registerStore.submit(context);
                            }
                          },
                          //: null,
                          loading: registerStore.loading,
                          loaderColor: Colors.white,
                          textColor: Colors.white,
                          color: AppColors.blueColor
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 17.0,
                    ),

                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFonts.Cabin,
                                fontStyle: FontStyle.normal),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: ' LOGIN',
                                  style: TextStyle(
                                      color: AppColors.orangeColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.Cabin,
                                      fontStyle: FontStyle.normal)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),

                  ],
                )),
          ),
        ],
      ),
    );
  }
}

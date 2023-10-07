// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speso_chat_app/screens/chat_screen.dart';
import 'package:speso_chat_app/screens/registration_screen.dart';
import 'package:speso_chat_app/store/login_store/login_store.dart';
import 'package:speso_chat_app/widgets/button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/image_assets.dart';
import '../constants/text_style.dart';
import '../utils/alert_dialogs.dart';
import '../widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginStore store = LoginStore();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    store.dispose();
    super.dispose();
  }

  @override
  void initState() {
    store.setupValidations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 80.0, left: 24.0, right: 24.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "LOGIN to your",
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppFonts.Cabin),
                  ),
                  Row(
                    children: const[
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
                  decoration: kDecorationStyle.copyWith(
                    border: Border.all(color: AppColors.greyColor),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 60),
                    children:  [

                      const Text(
                          'Email address',
                          textAlign: TextAlign.start,
                          style: kSmallTextStyle
                      ),
                      const SizedBox(height: 8.0,),
                      Observer(
                        builder: (_) =>InputField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          hint: "Email address",
                          onChanged: (text) {
                            store.email = text;
                            // if ( emailController.text.length>3 ) {
                            //  store.proceedButtonActive = true;
                            // } else {
                            //   store.proceedButtonActive = false;
                            // }
                          },
                          message: store.error.email,
                          error: store.error.email != null,
                          color: AppColors.blackColor,
                          hintColor: AppColors.greyColor,
                          textColor: AppColors.blackColor,
                          focusedColor: AppColors.borderColor,
                        ),
                      ),

                      const SizedBox(height: 14.0,),
                      const Text('Password', style:kSmallTextStyle),
                      const SizedBox(height: 8.0,),
                      Observer(
                        builder: (_) => InputField(
                          controller: passwordController,
                          type: TextInputType.text,
                          hint: 'Password',
                          obscureText:store.passwordVisible,
                          onChanged: (text) {
                            store.password = text;
                          },
                          suffixIcon: GestureDetector(
                              onTap: () => store.passwordVisible
                                  ? store.passwordVisible = false
                                  : store.passwordVisible = true,
                              child:
                              IconButton(
                                icon:store.passwordVisible ? Image.asset(assetEyeClosed, height: 10.0, width: 14.67,)
                                    :Image.asset(assetEyeOpen, height: 10.0, width: 14.67,),)
                          ),
                          message: store.error.password,
                          error: store.error.password != null,
                          color: AppColors.blackColor,
                          hintColor: AppColors.greyColor,
                          textColor: AppColors.blackColor,
                          focusedColor: AppColors.borderColor,
                        ),
                      ),





                      const SizedBox(height: 80.0,),
                      Observer(
                        builder: (ctx) =>  Container(
                          width: double.infinity,
                          child: Button(
                            text: 'Log In',
                            onPressed:  //store.proceedButtonActive ?
                                () {
                              FocusScope.of(context).unfocus();

                              if(store.hasErrors){
                              }  else if (emailController.text == null || emailController.text == " ") {
                                registerStore.error.email =
                                "Please enter your Password";
                              }  else if (passwordController.text == null ||
                                  passwordController.text == " " ) {
                                registerStore.error.password = "Please enter your Password";
                              }else {
                                store.submit(context);

                              }
                          },
                          //: null,
                           loading: store.loading,
                            loaderColor: Colors.white,
                            textColor: Colors.white,
                            color:
                            //store.proceedButtonActive
                                 AppColors.blueColor
                               // : AppColors.inactiveColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 17.0,),

                      Center(
                        child: InkWell(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Don\'t have an account?',
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.Cabin,
                                  fontStyle: FontStyle.normal
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Create one',
                                    style: TextStyle(
                                        color: AppColors.orangeColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFonts.Cabin,
                                        fontStyle: FontStyle.normal)),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegistrationScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

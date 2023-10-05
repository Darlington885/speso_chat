import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../utils/navigators.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 6), () async {
      navigateReplace(context, LoginScreen());
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.blueColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'Speso Chat',
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.Cabin
                        ),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

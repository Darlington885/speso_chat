

import 'package:flutter/material.dart';
import 'package:speso_chat_app/screens/chat_screen.dart';
import 'package:speso_chat_app/screens/login_screen.dart';
import 'package:speso_chat_app/screens/registration_screen.dart';

import '../screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {

    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RegistrationScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case ChatScreen.routeName:
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());



      default:

      // If there is no such named route in the switch statement, e.g. /third
      // return MaterialPageRoute(builder: (_) => LoginScreen());
    }
    return null;

  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

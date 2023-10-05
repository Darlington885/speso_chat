
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speso_chat_app/router/routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:speso_chat_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:speso_chat_app/utils/loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Setup orientation
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoaderProvider>(
            create: (context) => LoaderProvider()),
      ],
      child: const SpesoApp(),
    );
  }
}


class SpesoApp extends StatefulWidget {
  const SpesoApp({Key key}) : super(key: key);

  @override
  _SpesoAppState createState() => _SpesoAppState();
}

class _SpesoAppState extends State<SpesoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      builder:  DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


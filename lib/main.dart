import 'dart:developer';

import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/bottom_navigation.dart';
import 'package:accord/screens/get_started_screen.dart';
import 'package:accord/screens/splash_screen.dart';
import 'package:accord/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

bool firstRun;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  firstRun =
      await FlutterSecureStorage().read(key: 'firstRun') == null ? true : false;

  String token = await Storage().fetchToken();
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String token;
  MyApp({this.token});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Accord',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Poppins",
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent)),
      debugShowCheckedModeBanner: false,
      initialRoute: firstRun ? "onboard" : "home",
      routes: {
        "home": (context) => SplashScreen(),
        "onboard": (context) => GetStartedScreen()
      },
    );
  }
}

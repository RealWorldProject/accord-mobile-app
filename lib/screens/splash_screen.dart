import 'dart:async';

import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/bottom_navigation.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/services/storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Storage().fetchToken().then(
          (token) => Timer(
            Duration(milliseconds: 200),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: token == null || token.isEmpty
                    ? (context) => LoginScreen()
                    : (context) => BottomNavigation(),
              ),
            ),
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: FlutterLogo(),
      // child: Stack(
      //   children: [
      //     Image.asset("assets/images/app-icon.png"),
      //     CircularProgressIndicator(),
      //   ],
      // ),
    );
  }
}

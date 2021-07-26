import 'dart:async';

import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/bottom_navigation.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:accord/services/storage.dart';
import 'package:flutter/material.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key key}) : super(key: key);

  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    Storage().fetchToken().then(
          (token) => Timer(
            Duration(milliseconds: 5000),
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
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      // duration: 600,
      imageSize: 150,

      imageSrc: "assets/images/icon.png",
      text: "accord",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 60.0,
        fontFamily: "MMCruella",
        fontWeight: FontWeight.w700
      ),
      colors: [
        Colors.blue,
        Colors.purple,
        Colors.orange,
        Colors.indigo[700],
      ],

      // colors: [
      //   Colors.white,
      //   Colors.indigo[700],
      //   Colors.grey[400],
      //   Colors.purple,
      // ],
      // backgroundColor: Color(0xff1b98e0),
      backgroundColor: Colors.white,
        pageRouteTransition: PageRouteTransition.SlideTransition,

      speed: 1,

    );
  }
}

import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/bottom_navigation.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:accord/services/storage.dart';
import 'package:flutter/material.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key key}) : super(key: key);

  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {


  String _userToken;

  @override
  void initState() {
    Storage().fetchToken().then((token) => setState(
          () {
            _userToken = token;
          },
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(

      navigateRoute: _userToken != null
          ? _userToken.isNotEmpty
              ? BottomNavigation()
              : LoginScreen()
          : LoginScreen(),
      imageSize: 130,
      imageSrc: "assets/images/icon.png",
      text: "accord",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 55.0,
        fontFamily: "MMCruella",
        fontWeight: FontWeight.w700,
      ),
      colors: [
        Colors.blue,
        Colors.purple,
        Colors.orange,
        Colors.indigo[700],
      ],
      backgroundColor: Colors.white,
      pageRouteTransition: PageRouteTransition.SlideTransition,
      speed: 1,
    );
  }
}

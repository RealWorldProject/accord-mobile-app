import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/get_started_screen.dart';
import 'package:accord/screens/bottom_navigation.dart';
import 'package:accord/shimmer/home/category/all_categories_shimmer.dart';
import 'package:accord/shimmer/home/category/category_shimmer.dart';
import 'package:accord/shimmer/home_screen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Poppins", bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent
      )),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),

      // home: HomeScreenShimmer(),

      // initialRoute: initScreen == 0 || initScreen == null ? "onboard" : "home",
      // routes: {
      //   "home": (context) => LoginScreen(),
      //   "onboard": (context) => GetStartedScreen()
      // },
    );
  }
}

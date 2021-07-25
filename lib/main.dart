import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/bottom_navigation.dart';
import 'package:accord/screens/get_started_screen.dart';
import 'package:accord/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

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
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Poppins",
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent)),
      debugShowCheckedModeBanner: false,
      // home: BottomNavigation(),

      // home: LoginScreen(),

      initialRoute: initScreen == 0 || initScreen == null ? "onboard" : "home",
      routes: {
        "home": token != null && token.isNotEmpty
            ? (context) => BottomNavigation()
            : (context) => LoginScreen(),
        "onboard": (context) => GetStartedScreen()
      },
    );
  }
}

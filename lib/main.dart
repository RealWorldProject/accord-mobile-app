import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/get_started_screen.dart';
import 'package:accord/screens/widgets/navigation_bar.dart';
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
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Poppins"),
        debugShowCheckedModeBanner: false,
        home: LoginScreen()

        // initialRoute:
        //     initScreen == 0 || initScreen == null ? 'onboard' : 'home',
        // routes: {
        //   'home': (context) => LoginScreen(),
        //   'onboard': (context) => GetStartedScreen()
        // },
    );
  }
}

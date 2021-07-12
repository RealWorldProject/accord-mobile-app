import 'package:accord/screen/login_creen.dart';
import 'package:accord/screens/get_started_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);
  // isviewed = prefs.getInt('GetStartedScreen');
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
        // home: isviewed != 0? GetStartedScreen():LoginScreen(),
        initialRoute:
            initScreen == 0 || initScreen == null ? 'onboard' : 'home',
        routes: {
          'home': (context) => LoginScreen(),
          'onboard': (context) => GetStartedScreen()
        });
    );
  }
}

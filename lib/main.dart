import 'package:accord/screens/get_started_screen.dart';
import 'package:accord/screens/splash_screen.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

bool firstRun;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  firstRun =
      await FlutterSecureStorage().read(key: 'firstRun') == null ? true : false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String token;
  MyApp({this.token});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        )
      ],
      builder: (context, child) => MaterialApp(
        title: 'Welcome to Accord',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "Poppins",
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Colors.transparent)),
        initialRoute: firstRun ? "onboard" : "home",
        routes: {
          "home": (context) => Splash_Screen(),
          "onboard": (context) => GetStartedScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

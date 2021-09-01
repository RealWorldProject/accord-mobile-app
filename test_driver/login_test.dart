// import 'package:accord/constant/accord_labels.dart';
// import 'package:accord/screens/widgets/custom_button.dart';
// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:test/test.dart';
// import 'package:flutter/material.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:toast/toast.dart';
//
// void main(){
//   group('Login Test',(){
//     FlutterDriver driver;
//
//     final getStarted = find.byValueKey("getstarted");
//     final emailFormField = find.byValueKey("email");
//     final passwordFormField = find.byValueKey("password");
//     final loginButton = find.byValueKey("login");
//
//     // Connect to the Flutter driver before running any tests.
//     setUpAll(() async {
//       driver = await FlutterDriver.connect();
//     });
//
//     // Close the connection to the driver after the tests have completed.
//     tearDownAll(() async {
//       if (driver != null) {
//         driver.close();
//       }
//     });
//
//     Future<bool> isPresent(SerializableFinder byValueKey,
//         {Duration timeout = const Duration(seconds: 1)}) async {
//       try {
//         await driver.waitFor(byValueKey, timeout: timeout);
//         return true;
//       } catch (exception) {
//         return false;
//       }
//     }
//
//     test( 'login',() async{
//       if (await isPresent(loginButton)) {
//         await driver.tap(loginButton);
//       }
//       await driver.tap(getStarted);
//
//       await driver.tap(emailFormField);
//       await driver.enterText("tadas1@gmail.com");
//
//       await driver.tap(passwordFormField);
//       await driver.enterText("123456");
//
//       await driver.tap(loginButton);
//       await driver.waitFor(find.text("Categories"));
//     });
//
//   });
// }

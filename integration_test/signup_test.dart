import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:accord/main.dart' as app;

void main(){
  group('Signup Test',(){
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("Signup Test", (tester) async{
      app.main();
      await tester.pumpAndSettle();

      final getStarted = find.byKey(Key("getstarted"));
      final signup = find.byKey(Key("signup"));
      final firstNameFormField = find.byKey(Key("firstName"));
      final lastNameFormField = find.byKey(Key("lastName"));
      final emailFormField = find.byKey(Key("email"));
      final passwordFormField = find.byKey(Key("password"));
      final registerButton = find.byKey(Key("register"));
      
      await tester.tap(getStarted);
      await tester.pumpAndSettle();

      await tester.tap(signup);
      await tester.pumpAndSettle();


      await tester.enterText(firstNameFormField, "Test");
      await tester.pumpAndSettle();

      await tester.enterText(lastNameFormField, "Test");
      await tester.pumpAndSettle();

      await tester.enterText(emailFormField, "test@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(passwordFormField, "test123");

      await tester.pumpAndSettle();

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      final toast = find.byKey(key)

      // expect()



    });

  });
}
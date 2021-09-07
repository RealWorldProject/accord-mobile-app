import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/profile/user/user_screen.dart';
import 'package:accord/screens/widgets/custom_button.dart';
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
      final emailFormField = find.byKey(Key("email"));
      final passwordFormField = find.byKey(Key("password"));
      final loginButton = find.byType(CustomButton).first;
      final editfullnameButton = find.byType(CustomButton).first;
      final profileButton = find.byType(InkWell).last;
      final userProfile = find.byKey(Key("profile")).first;
      final editUserButton = find.byKey(Key("edituser")).first;
      final editfullname = find.byKey(Key("editfullname")).first;
      final fullnamefield = find.byKey(Key("fullname")).first;


      await tester.tap(getStarted);
      await tester.pumpAndSettle();


      await tester.enterText(emailFormField, "prasanna@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(passwordFormField, "prasanna");

      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      await tester.tap(userProfile);
      await tester.pumpAndSettle();

      await tester.tap(editUserButton);
      await tester.pumpAndSettle();

      await tester.tap(editfullname);
      await tester.pumpAndSettle();

      await tester.enterText(fullnamefield, "John Cena");
      await tester.pumpAndSettle();

      await tester.tap(editfullnameButton);
      await tester.pumpAndSettle();


      expect(find.text(AccordLabels.okay),findsOneWidget);


      await (tester.pump(Duration(milliseconds: 5000)));
      await tester.pumpAndSettle();

      // expect()



    });

  });
}
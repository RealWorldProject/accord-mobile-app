import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:accord/main.dart' as app;
import 'package:toast/toast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

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
      final loginguide = find.byKey(Key("loginguide"));
      final registerButton = find.byType(CustomButton).first;
      
      await tester.tap(getStarted);
      await tester.pumpAndSettle();

      await tester.tap(signup);
      await tester.pumpAndSettle();


      await tester.enterText(firstNameFormField, "Prasanna");
      await tester.pumpAndSettle();

      await tester.enterText(lastNameFormField, "Adhikari");
      await tester.pumpAndSettle();

      await tester.enterText(emailFormField, "prasanna@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(passwordFormField, "prasanna");

      await tester.pumpAndSettle();

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      // final toast = find.byKey(key)
      final snackbar = find.byKey(Key("loginguide"));

      expect(find.text(AccordLabels.okay),findsOneWidget);

      // expect(tester.getSemantics(snackbar), matchesSemantics(
      //   label: AccordLabels.loginGuide,
      // ),);
      await (tester.pump(Duration(milliseconds: 5000)));
      await tester.pumpAndSettle();

      // expect()



    });

  });
}
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:accord/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Signup Test', () {
    testWidgets("Signup Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final getStarted = find.byKey(Key("getstarted"));
      final signup = find.byKey(Key("signup"));
      final firstNameFormField = find.byKey(Key("firstName"));
      final lastNameFormField = find.byKey(Key("lastName"));
      final emailFormField = find.byKey(Key("email"));
      final passwordFormField = find.byKey(Key("password"));
      final registerButton = find.byType(CustomButton).first;

      await tester.tap(getStarted);
      await tester.pumpAndSettle();

      await tester.tap(signup);
      await tester.pumpAndSettle();

      await tester.enterText(firstNameFormField, "test");
      await tester.pumpAndSettle();

      await tester.enterText(lastNameFormField, "user");
      await tester.pumpAndSettle();

      await tester.enterText(emailFormField, "testuser@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(passwordFormField, "test123");

      await tester.pumpAndSettle();

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(find.text(AccordLabels.okay), findsOneWidget);

      await (tester.pump(Duration(milliseconds: 5000)));
      await tester.pumpAndSettle();
    });
  });
}

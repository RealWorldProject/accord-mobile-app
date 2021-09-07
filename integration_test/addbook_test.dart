import 'package:accord/screens/widgets/custom_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:accord/main.dart' as app;

void main() {
  group('Add Book Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("Add Book Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final getStarted = find.byKey(Key("getstarted"));
      final emailFormField = find.byKey(Key("email"));
      final passwordFormField = find.byKey(Key("password"));
      final loginButton = find.byType(CustomButton).first;
      final addButton = find.byType(FloatingActionButton).first;
      final addImage = find.byKey(Key("addImage"));

      await tester.tap(getStarted);
      await tester.pumpAndSettle();

      await tester.enterText(emailFormField, "checkwat7@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(passwordFormField, "check123");

      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      await tester.tap(addImage);
      await tester.pumpAndSettle();

      // expect(find.text(AccordLabels.categoriesLabel),findsOneWidget);

      await (tester.pump(Duration(milliseconds: 5000)));
      await tester.pumpAndSettle();

      // expect()
    });
  });
}

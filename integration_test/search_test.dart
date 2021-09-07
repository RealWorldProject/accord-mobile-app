import 'package:accord/screens/home/search_field.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:accord/main.dart' as app;

void main() {
  group('Search', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("Search Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final getStarted = find.byKey(Key("getstarted"));
      final emailFormField = find.byKey(Key("email"));
      final passwordFormField = find.byKey(Key("password"));
      final searchFieldInput = find.byKey(Key("searchField"));
      final searchContainer = find.byKey(Key("searchcontainer"));
      final loginButton = find.byType(CustomButton).first;
      final searchField = find.byType(SearchField).first;

      await tester.tap(getStarted);
      await tester.pumpAndSettle();

      await tester.enterText(emailFormField, "checkwat7@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(passwordFormField, "check123");

      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      await tester.tap(searchField);
      await tester.pumpAndSettle();
      await tester.enterText(searchFieldInput, "agile");
      await tester.tap(searchContainer);

      expect(find.text("Agile Book"), findsOneWidget);

      await (tester.pump(Duration(milliseconds: 5000)));
      await tester.pumpAndSettle();

      // expect()
    });
  });
}

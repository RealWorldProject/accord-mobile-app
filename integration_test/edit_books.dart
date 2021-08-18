import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:accord/main.dart' as app;

void main(){
   group('Edit Books',(){
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets("Edit Books Test", (tester) async{
         app.main();
         await tester.pumpAndSettle();

         final getStarted = find.byKey(Key("getstarted"));

         final emailFormField = find.byKey(Key("email"));
         final passwordFormField = find.byKey(Key("password"));
         final loginButton = find.byKey(Key("btnLogin"));

         await tester.tap(getStarted);
         await tester.pumpAndSettle();

         await tester.enterText(emailFormField, "test@gmail.com");
         await tester.pumpAndSettle();

         await tester.enterText(passwordFormField, "test123");
         await tester.pumpAndSettle();

         await tester.tap(loginButton);
         await tester.pumpAndSettle();
      });
   });
}
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/book_display_format.dart';
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
      final addtocartButton = find.byKey(Key("addtocart")).first;
      // final addtocartButton = find.byType(InkWell).last;
      final cartButton = find.byKey(Key("buttonButton")).first;
      final bookDetail = find.byKey(Key("bookdetail")).first;
      final loginButton = find.byType(CustomButton).first;

      await tester.tap(getStarted);
      await tester.pumpAndSettle();


      await tester.enterText(emailFormField, "test@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(passwordFormField, "test123");

      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // final gesture = await tester.startGesture(Offset.zero /* THe position of your listview */ );
// Manual scroll
//       await gesture.moveBy(const Offset(100, 500));


      // final gesture = await tester.startGesture(Offset(0, 300)); //Position of the scrollview
      // await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      // await (tester.pump(Duration(milliseconds: 5000)));



      // await tester.tap(bookDetail);
      // // await tester.pump();
      // await (tester.pump(Duration(milliseconds: 3000)));

      // await tester.tapAt(Offset(164.9, 434.2)) ;

      // await tester.ensureVisible(addtocartButton);
      await tester.dragUntilVisible(
        addtocartButton, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 100), // delta to move
      );
      await tester.tap(addtocartButton);
      await (tester.pump(Duration(milliseconds: 3000)));
      await tester.pumpAndSettle();

      // (Offset(164.9, 434.2))
      await tester.tap(cartButton);
      await tester.pumpAndSettle();

      await (tester.pump(Duration(milliseconds: 6000)));
          // await tester.tap(bookDetail);
      // await tester.pump();
      await tester.pumpAndSettle();

      // expect(find.text(AccordLabels.categoriesLabel),findsOneWidget);

      // await (tester.pump(Duration(milliseconds: 5000)));

      // expect()



    });

  });
}
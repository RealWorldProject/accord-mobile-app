import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:accord/viewModel/category_view_model.dart';
import 'package:accord/viewModel/image_helper.dart';
import 'package:accord/viewModel/order_view_model.dart';
import 'package:accord/viewModel/screen_view_model.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool _isCart = false;
  bool _isNotification = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ScreenViewModel()),
          ChangeNotifierProvider(create: (context) => CategoryViewModel()),
          ChangeNotifierProvider(create: (context) => BookViewModel()),
          ChangeNotifierProvider(create: (context) => UserViewModel()),
          ChangeNotifierProvider(create: (context) => CartviewModel()),
          ChangeNotifierProvider(create: (context) => OrderViewModel()),
          ChangeNotifierProvider(create: (context) => ImageHelper()),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            home: Consumer<ScreenViewModel>(
              builder: (context, screenViewModel, child) {
                // possible items in bottom navigation bar.
                final List<GButton> gButtons = screenViewModel.screens
                    .map((screen) => GButton(
                          icon: screen.icon,
                          text: screen.label,
                          leading: screen.badgeManipulator,
                        ))
                    .toList();

                // possible screens that bottom navigation bar holds.
                final List<Widget> screens = screenViewModel.screens
                    .map((screen) => screen.child)
                    .toList();

                // page controller for bottom navigation.
                final PageController pageController =
                    screenViewModel.pageController;

                return WillPopScope(
                  onWillPop: () => screenViewModel.onWillPop(context),
                  child: Scaffold(
                    extendBody: true,
                    body: PageView(
                      controller: pageController,
                      // prevents swiping between pages
                      physics: NeverScrollableScrollPhysics(),
                      children: screens,
                    ),
                    bottomNavigationBar: Container(
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: Colors.blue.withOpacity(1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8),
                        child: GNav(
                          rippleColor: Colors.blue[300],
                          hoverColor: Colors.blue[100],
                          gap: 6,
                          activeColor: Colors.white,
                          iconSize: 24,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          duration: Duration(milliseconds: 400),
                          tabBackgroundColor: Colors.lightBlue,
                          color: Colors.blue[400],
                          tabs: gButtons,
                          selectedIndex: screenViewModel.currentScreenIndex,
                          onTabChange: (selectedScreenIndex) {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            screenViewModel.setScreen(selectedScreenIndex);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }));
  }
}

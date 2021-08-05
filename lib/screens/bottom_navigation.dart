import 'package:accord/screens/cart/cart_screen.dart';
import 'package:accord/screens/home/home_screen.dart';
import 'package:accord/screens/notification/notification_page.dart';
import 'package:accord/screens/profile/profile_screen.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedPageIndex = 0;

  List<Widget> _pages;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = 0;

    _pages = [
      ChangeNotifierProvider(
        create: (context) => CartviewModel(),
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => CartviewModel(),
        child: CartScreen(),
      ),
      NotificationScreen(),
      ProfileScreen(),
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartviewModel()),
      ],
      child: Scaffold(
        extendBody: true,
        // body: SafeArea(child: _screens[_selectedIndex]),
        body: PageView(
          controller: _pageController,
          // prevents swiping between pages
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.blue[300],
              hoverColor: Colors.blue[100],
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.lightBlue,
              color: Colors.blue[400],
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'Cart',
                ),
                GButton(
                  icon: LineIcons.bellAlt,
                  text: 'Notifications',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedPageIndex,
              onTabChange: (selectedPageIndex) {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }

                setState(() {
                  _selectedPageIndex = selectedPageIndex;
                  _pageController.jumpToPage(selectedPageIndex);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

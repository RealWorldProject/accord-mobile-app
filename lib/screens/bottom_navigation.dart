import 'package:accord/screens/cart/cart_screen.dart';
import 'package:accord/screens/home/home_screen.dart';
import 'package:accord/screens/notification/notification_page.dart';
import 'package:accord/screens/profile/profile_screen.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedPageIndex = 0;
    bool _isCart = false;
    bool _isNotification = false;

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
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.blue[300],
              hoverColor: Colors.blue[100],
              gap: 6,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.lightBlue,
              color: Colors.blue[400],

              tabs: [
                GButton(
                  icon: LineIcons.home,

                  text: 'Home',

                ),



                GButton(
                  text: 'Cart',

                  leading: Badge(
                    badgeContent: Text('3',style: TextStyle(color: Colors.white,fontSize: 9,fontWeight: FontWeight.bold),),
                    shape: BadgeShape.circle,
                    alignment: Alignment.topRight,
                    child: !_isCart?Icon(LineIcons.shoppingCart, color: Colors.blue[400],size: 27,):Icon(LineIcons.shoppingCart, color: Colors.white),
                   position: BadgePosition.topEnd(top: -8,end: -10),
                    showBadge: !_isCart?true:false,
                  )
                  // leading: Stack(
                  //   children: [
                  //     Icon(LineIcons.shoppingCart),
                  //
                  //   ],
                  // ),
                ),
                GButton(
                  text: 'Notifications',
                    leading: Badge(

                      badgeContent: Text('2',style: TextStyle(color: Colors.white,fontSize: 9,fontWeight: FontWeight.bold),),
                      shape: BadgeShape.circle,
                      // alignment: Alignment.centerRight,
                      child: !_isNotification?Icon(LineIcons.bellAlt, color: Colors.blue[400],size: 27,):Icon(LineIcons.bellAlt, color: Colors.white),

                      position: BadgePosition.topEnd(top: -8,end: -6),
                      showBadge: !_isNotification?true:false,
                    )
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                  iconSize: 27,
                ),
              ],

              selectedIndex: _selectedPageIndex,
              onTabChange: (selectedPageIndex) {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                if(selectedPageIndex == 1){

                  _isCart = true;
                }else{
                  _isCart = false;
                }
                if(selectedPageIndex == 2){

                  _isNotification = true;
                }else{
                  _isNotification = false;
                }

                setState(() {
                  _selectedPageIndex = selectedPageIndex;
                  // _isCart = !_isCart;
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

import 'package:accord/models/screen.dart';
import 'package:accord/screens/cart/cart_screen.dart';
import 'package:accord/screens/home/home_screen.dart';
import 'package:accord/screens/notification/notification_page.dart';
import 'package:accord/screens/profile/profile_screen.dart';
import 'package:accord/screens/widgets/custom_dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

const HOME_SCREEN = 0;
const CART_SCREEN = 1;
const NOTIFICATION_SCREEN = 2;
const PROFILE_SCREEN = 3;

class ScreenViewModel extends ChangeNotifier {
  static int _currentScreenIndex = HOME_SCREEN;
  int get currentScreenIndex => _currentScreenIndex;

  PageController _pageController = PageController(initialPage: HOME_SCREEN);
  PageController get pageController => _pageController;

  final Map<int, Screen> _screens = {
    HOME_SCREEN: Screen(
      label: "Home",
      icon: LineIcons.home,
      child: HomeScreen(),
      scrollController: ScrollController(),
    ),
    CART_SCREEN: Screen(
      label: "Cart",
      icon: LineIcons.shoppingCart,
      child: CartScreen(),
      scrollController: ScrollController(),
    ),
    NOTIFICATION_SCREEN: Screen(
      label: "Notification",
      icon: LineIcons.bellAlt,
      child: NotificationScreen(),
      scrollController: ScrollController(),
    ),
    PROFILE_SCREEN: Screen(
      label: "Profile",
      icon: LineIcons.user,
      child: ProfileScreen(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex];

  void restoreInitialTab(int screenIndex) {
    _currentScreenIndex = screenIndex;
  }

  // set currently visible tab
  void setScreen(int screen) {
    if (screen == currentScreenIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = screen;

      pageController.animateToPage(
        _currentScreenIndex,
        duration: Duration(milliseconds: 90),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  // if currently displayed screen has ScrollController,
  // animate it to the start of scroll view
  void _scrollToStart() {
    if (currentScreen.scrollController != null &&
        currentScreen.scrollController.hasClients) {
      currentScreen.scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // WillPopScope, back-button callback manager
  Future<bool> onWillPop(BuildContext context) async {
    if (currentScreenIndex != HOME_SCREEN) {
      setScreen(HOME_SCREEN);
      return false;
    } else {
      return await showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) => CustomDialogBox(
          title: "Exit Accord?",
          neglectLabel: "Cancel",
          neglectAction: () => Navigator.of(context).pop(false),
          performLabel: "Exit",
          performAction: () => Navigator.of(context).pop(true),
        ),
      );
    }
  }
}

// class DisplayBadge extends StatelessWidget {
//   const DisplayBadge({Key key, this.icon}) : super(key: key);

//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return Badge(
//       badgeContent: Text(
//         '2',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 9,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       shape: BadgeShape.circle,
//       child: Icon(
//         icon,
//         color: Colors.blue[400],
//         size: 27,
//       ),
//       position: BadgePosition.topEnd(top: -8, end: -6),
//       // showBadge: inBadgeScreen ? false : true,
//     );
//   }
// }

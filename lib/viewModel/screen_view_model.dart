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
  int _currentScreenIndex = HOME_SCREEN;

  int get currentScreenIndex => _currentScreenIndex;

  final Map<int, Screen> _screens = {
    HOME_SCREEN: Screen(
      name: "Home",
      icon: LineIcons.home,
      child: HomeScreen(),
      navigatorState: GlobalKey<NavigatorState>(),
      scrollController: ScrollController(),
    ),
    CART_SCREEN: Screen(
      name: "Cart",
      icon: LineIcons.shoppingCart,
      child: CartScreen(),
      navigatorState: GlobalKey<NavigatorState>(),
      scrollController: ScrollController(),
    ),
    NOTIFICATION_SCREEN: Screen(
      name: "Notification",
      icon: LineIcons.bellAlt,
      child: NotificationScreen(),
      navigatorState: GlobalKey<NavigatorState>(),
      scrollController: ScrollController(),
    ),
    PROFILE_SCREEN: Screen(
      name: "Profile",
      icon: LineIcons.user,
      child: ProfileScreen(),
      navigatorState: GlobalKey<NavigatorState>(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex];

  // set currently visible tab
  void setTab(int screen) {
    if (screen == currentScreenIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = screen;
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
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentScreenIndex != HOME_SCREEN) {
        setTab(HOME_SCREEN);
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => CustomDialogBox(
            title: "Exit Accord?",
            dontText: "Cancel",
            dontAction: () => Navigator.of(context).pop(false),
            doText: "Exit",
            doAction: () => Navigator.of(context).pop(true),
          ),
        );
      }
    }
  }
}

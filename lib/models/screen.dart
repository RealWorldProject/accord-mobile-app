import 'package:flutter/material.dart';

class Screen {
  // tab name displayed in bottom navigation bar
  final String name;

  // tab icon displayed in bottom navigation bar
  final IconData icon;

  // screen contents
  final Widget child;

  // route generator for this screen's inner navigator
  // final RouteFactory onGenerateRoute;

  // initial route. needs to be handled in onGenerateRoute
  // final String initialRoute;

  // navigator state for corresponding screen
  final GlobalKey<NavigatorState> navigatorState;

  // scroll views manipulator
  final ScrollController scrollController;

  Screen({
    @required this.name,
    @required this.icon,
    @required this.child,
    // @required this.onGenerateRoute,
    // @required this.initialRoute,
    @required this.navigatorState,
    this.scrollController,
  });
}

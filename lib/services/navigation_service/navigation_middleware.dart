import 'dart:developer' as d;

import 'package:flutter/material.dart';


class GoRouteMiddleware extends NavigatorObserver {
  static List<String> backStack = [];

  @override
  void didPop(Route route, Route? previousRoute) {
    backStack.removeLast();
    d.log(':::::: popped: ${route.settings.name} ::::::');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    backStack.add(route.settings.name ?? '');
    d.log(':::::: pushed: ${route.settings.name} ::::::');
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    backStack.removeLast();
    backStack.add(newRoute?.settings.name ?? '');
    d.log(':::::: popped: ${oldRoute?.settings.name} ::::::');
    d.log(':::::: pushed: ${newRoute?.settings.name} ::::::');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  String toString() {
    return backStack.toString();
  }
}
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  String? getCurrentScreenName() {
    String? currentScreenName;
    _navigationKey.currentState?.popUntil((route) {
      currentScreenName = route.settings.name;
      return true;
    });
    return currentScreenName;
  }

  Future<dynamic> removeAndNavigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(routeName, (r) => false, arguments: arguments);
  }
}

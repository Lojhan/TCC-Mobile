import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic>? navigateToReplacement(String rn) {
    return navigationKey.currentState?.pushReplacementNamed(rn);
  }

  Future<dynamic>? navigateTo(String rn) {
    return navigationKey.currentState?.pushNamed(rn);
  }

  Future<dynamic>? navigateToRoute(MaterialPageRoute rn) {
    return navigationKey.currentState?.push(rn);
  }

  void goback() {
    return navigationKey.currentState?.pop();
  }
}

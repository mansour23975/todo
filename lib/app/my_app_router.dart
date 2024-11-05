import 'package:flutter/material.dart';
import 'package:todo_flutter_app/catalog/view/splash/splash_screen.dart';
import '../catalog/view/home/view/home_screen.dart';
import '../catalog/view/profile/view/login_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Widget getScreenByName({required RouteSettings settings}) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return const SplashScreen();
      case AppRoutes.homeScreen:
        return const HomeScreen();
      case AppRoutes.loginScreen:
        return const LoginScreen();
      default:
        return const Scaffold(
          body: SafeArea(
            child: Text(
              'Route Error',
            ),
          ),
        );
    }
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) {
          return getScreenByName(settings: settings);
        },
        settings: settings);
  }

  static Route<dynamic> onUnknownRoute(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (
        buildContext,
      ) =>
          const Scaffold(
        body: SafeArea(
          child: Text(
            'Route Error',
          ),
        ),
      ),
      settings: null,
    );
  }
}

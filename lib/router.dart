import 'package:e_commerce_project_ws_cube/features/auth/screens/auth_screens.dart';
import 'package:e_commerce_project_ws_cube/features/home/screens/home_screens.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreens.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AuthScreens(),
      );
    case HomeScreens.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomeScreens(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Screen does not exits'),
            ),
          );
        },
      );
  }
}

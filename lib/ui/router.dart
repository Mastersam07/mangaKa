import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint(settings.name);
    switch (settings.name) {
      // case RoutePaths.Login:
      //   return MaterialPageRoute(builder: (_) => const SignIn());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

import 'package:first_step/core/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/login/login_screen.dart';

class AppRouter {
  Route generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Text("ERROR"),
                ));
    }
  }
}

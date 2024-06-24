import 'package:first_step/core/routing/routes.dart';
import 'package:first_step/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/SignUp/logic/cubit/sign_up_cubit.dart';
import '../../features/SignUp/ui/screen/signup_screen.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/ui/screen/login_screen.dart';
import '../di/depndency_injection.dart';

class AppRouter {
  Route generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case Routes.homeScreen:
         return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text("HOME")),
                ));
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Text("ERROR"),
                ));
     }
  }
}

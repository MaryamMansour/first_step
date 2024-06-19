import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/features/home/ui/home_layout_screen.dart';
import 'package:first_step/features/login/ui/screen/login_screen.dart';
import 'package:first_step/features/profile/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'core/routing/routes.dart';
import 'main.dart';

class SplashScreen  extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Center(
          child: Lottie.asset(
            'assets/animation/splah_screen.json'
          ),
        ),
        nextScreen: isUserLogged? HomeScreen():
        LoginScreen(),
    duration: 3050,
    splashIconSize: 800,
    backgroundColor:  AppColors.primaryColor,);

  }
}

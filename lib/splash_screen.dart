import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:first_step/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen  extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Center(
          child: Lottie.asset(
            'assets/animation/splash_screen.json'
          ),
        ),
        nextScreen: LoginScreen(),
    duration: 3050,
    splashIconSize: 800,
    backgroundColor:  Color(0xFF0D5661),);
    //TODO add color to colors file
  }
}

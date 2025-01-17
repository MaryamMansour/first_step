import 'package:first_step/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        horizontalSpace(130),
        Image.asset(width: 30,height: 30,'assets/images/facebook.png'),
        horizontalSpace(40),
        Image.asset(width: 25,height: 25,'assets/images/google.png'),
        horizontalSpace(30),
        Image.asset(width: 30,height: 30,'assets/images/apple.png'),
      ],
    );
  }
}

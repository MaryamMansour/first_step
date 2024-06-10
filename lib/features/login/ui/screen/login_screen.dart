import 'package:first_step/core/widgets/text_form_field.dart';
import 'package:first_step/features/login/ui/widgets/login_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body:
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(50),
              Image.asset('assets/images/logo3.png'),
              verticalSpace(20),
              LoginContainerWidget(),
            ],
          ),
        ),
      ),


    );
  }
}

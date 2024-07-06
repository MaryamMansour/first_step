import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/widgets/text_form_field.dart';
import 'package:first_step/features/SignUp/ui/widgets/have_account.dart';
import 'package:first_step/features/SignUp/ui/widgets/sign_up_bloc_listener.dart';
import 'package:first_step/features/SignUp/ui/widgets/signup_button.dart';
import 'package:first_step/features/SignUp/ui/widgets/signup_text_filelds.dart';
import 'package:first_step/features/SignUp/ui/widgets/signup_welcome_widget.dart';
import 'package:first_step/features/SignUp/ui/widgets/user_type.dart';
import 'package:first_step/features/login/ui/widgets/login_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/app_regex.dart';
import '../../../../core/theming/styles.dart';
import '../../../login/ui/widgets/divider_widget.dart';
import '../../../login/ui/widgets/dont_have_acc.dart';
import '../../../login/ui/widgets/social_media_icon.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body:
        SafeArea(
          child:SingleChildScrollView(
            child: Column(
              children: [
              const WelcomeWidget(),
              verticalSpace(30),
              const SignupTextFields(),
               // Radio(value: , groupValue: groupValue, onChanged: onChanged)
                // UserType(),
                const SignupButton(),
               verticalSpace(40),
               const HaveAccount(),
                verticalSpace(50),
                const SignupBlocListener(),
              ],
            )
          ),
        )

    );
  }
}

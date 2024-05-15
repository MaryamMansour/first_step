import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/features/login/ui/widgets/email_and_password.dart';
import 'package:first_step/features/login/ui/widgets/social_media_icon.dart';
import 'package:first_step/features/login/ui/widgets/welcome_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/text_button.dart';
import 'divider_widget.dart';
import 'dont_have_acc.dart';

class LoginContainerWidget extends StatefulWidget {
  const LoginContainerWidget({super.key});

  @override
  State<LoginContainerWidget> createState() => _LoginContainerWidgetState();
}

class _LoginContainerWidgetState extends State<LoginContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 453.w,
        height: 747.h,
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70),
            )),
        child: Column(
          children: [
            const WelcomeBackWidget(),
            verticalSpace(60),
            const EmailAndPassword(),
            verticalSpace(20),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 42),
                child: Text(
                  "Forgot Password?",
                  style: AppTextStyles.font12PrimaryRegular,
                ),
              )
            ]),
            verticalSpace(50),
            AppTextButton(
              buttonText: "Login",
              onPressed: () {},
            ),
            verticalSpace(30),
            DividerWidget(),
            verticalSpace(20),
            SocialMediaIcon(),
            verticalSpace(40),
            DontHaveAccount(),
          ],
        ));
  }
}

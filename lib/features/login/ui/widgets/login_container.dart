import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/login/ui/widgets/email_and_password.dart';
import 'package:first_step/features/login/ui/widgets/social_media_icon.dart';
import 'package:first_step/features/login/ui/widgets/welcome_widget.dart';
import '../../../../core/di/depndency_injection.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/text_button.dart';
import '../../logic/cubit/login_cubit.dart';
import 'divider_widget.dart';
import 'dont_have_acc.dart';
import 'login_block_listener.dart';
import 'login_button.dart';

class LoginContainerWidget extends StatefulWidget {
  const LoginContainerWidget({super.key});

  @override
  State<LoginContainerWidget> createState() => _LoginContainerWidgetState();
}

class _LoginContainerWidgetState extends State<LoginContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Container(
        width: 453.w,
        height: 747.h,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(70),
          ),
        ),
        child: Column(
          children: [
            const WelcomeBackWidget(),
            verticalSpace(60),
            const EmailAndPassword(),
            verticalSpace(20),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Text(
                  "Forgot Password?",
                  style: AppTextStyles.font12PrimaryRegular,
                ),
              )
            ]),
            verticalSpace(50),
           const LoginButton(),
            verticalSpace(10),
            const DividerWidget(),
            verticalSpace(10),
            const SocialMediaIcon(),
            verticalSpace(10),
            const DontHaveAccount(),
            const LoginBlocListener(),
          ],
        ),
      ),
    );





  }


}

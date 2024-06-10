import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/cubit/login_cubit.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        horizontalSpace(50),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an account?',
                style: AppTextStyles.font12PrimaryRegular.copyWith(fontSize: 14.sp),
              ),
              TextSpan(
                text: ' Sign Up',
                style: AppTextStyles.font15PrimaryBold,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                  //TODO signup
                    // context.pushReplacementNamed(Routes.signUpScreen);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

}

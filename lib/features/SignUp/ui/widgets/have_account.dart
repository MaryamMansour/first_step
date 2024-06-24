import 'package:first_step/core/helper/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        horizontalSpace(50),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Already have an account?',
                style: AppTextStyles.font12PrimaryRegular.copyWith(
                    fontSize: 14.sp),
              ),
              TextSpan(
                text: '  Login ',
                style: AppTextStyles.font15PrimaryBold,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //TODO signup
                    context.pushReplacementNamed(Routes.loginScreen);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}


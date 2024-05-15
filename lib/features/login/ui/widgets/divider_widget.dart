import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        horizontalSpace(42),
        SizedBox(
            width: 160.w,
            height: 1.h,
            child: DecoratedBox(
              decoration: BoxDecoration(color: AppColors.lightGray),
            )),
        SizedBox(
          width: 30,
          child: Center(
              child: Text(
                "or",
                style: AppTextStyles.font12PrimaryRegular,
              )),
        ),
        SizedBox(
            width: 160.w,
            height: 1.h,
            child: DecoratedBox(
              decoration: BoxDecoration(color: AppColors.lightGray),
            )),
      ],
    );
  }
}

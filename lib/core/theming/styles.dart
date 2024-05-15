
import 'package:flutter/material.dart';

import 'package:first_step/core/theming/font_weights.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTextStyles{
   static TextStyle font24PrimaryBold = TextStyle(
    fontSize: 30.sp,
     color: AppColors.primaryColor,
     fontWeight: FontWeightHelper.bold
   );
   static TextStyle font12PrimaryRegular = TextStyle(
    fontSize: 18.sp,
     color: AppColors.primaryColor,
     fontWeight: FontWeightHelper.regular
   );
   static TextStyle font16PrimaryLight = TextStyle(
    fontSize: 16.sp,
     color: AppColors.primaryColor,
     fontWeight: FontWeightHelper.light,
   );
   static TextStyle font16GrayLight = TextStyle(
    fontSize: 16.sp,
     color: AppColors.lightGray,
     fontWeight: FontWeightHelper.light,
   );
   static TextStyle font20WhiteBold = TextStyle(
    fontSize: 26.sp,
     color: AppColors.white,
     fontWeight: FontWeightHelper.bold,
   );
   static TextStyle font15PrimaryBold = TextStyle(
    fontSize: 15.sp,
     color: AppColors.primaryColor,
     fontWeight: FontWeightHelper.bold,
   );


}
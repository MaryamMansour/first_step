import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/font_weights.dart';
import '../theming/styles.dart';


class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(

        controller: controller,
        decoration: InputDecoration(
          labelStyle: AppTextStyles.font16GrayLight.copyWith(color:AppColors.gray, fontWeight: FontWeightHelper.regular ),
          isDense: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.lightGray,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintStyle: hintStyle ?? AppTextStyles.font16GrayLight,
          hintText: hintText,
          suffixIcon: suffixIcon,
          fillColor: backgroundColor ??AppColors.white,
          filled: true,
        ),
        obscureText: isObscureText ?? false,
        style: AppTextStyles.font16PrimaryLight,
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../theming/colors.dart';
// import '../theming/styles.dart';
//
// class AppTextFormField extends StatelessWidget {
//   final EdgeInsetsGeometry? contentPadding;
//   final InputBorder? focusedBorder;
//   final InputBorder? enabledBorder;
//   final TextStyle? inputTextStyle;
//   final TextStyle? hintStyle;
//   final String hintText;
//   final bool? isObscureText;
//   final Widget? suffixIcon;
//   final Color? backgroundColor;
//   final TextEditingController? controller;
//   final Function(String?) validator;
//   const AppTextFormField({
//     super.key,
//     this.contentPadding,
//     this.focusedBorder,
//     this.enabledBorder,
//     this.inputTextStyle,
//     this.hintStyle,
//     required this.hintText,
//     this.isObscureText,
//     this.suffixIcon,
//     this.backgroundColor,
//     this.controller,
//     required this.validator,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           isDense: true,
//           contentPadding: contentPadding ??
//               EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
//           focusedBorder: focusedBorder ??
//               OutlineInputBorder(
//                 borderSide: const BorderSide(
//                   color: AppColors.primaryColor,
//                   width: 1.3,
//                 ),
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//           enabledBorder: enabledBorder ??
//               OutlineInputBorder(
//                 borderSide: const BorderSide(
//                   color: AppColors.gray,
//                   width: 1.3,
//                 ),
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//           errorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.red,
//               width: 1.3,
//             ),
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.red,
//               width: 1.3,
//             ),
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           hintStyle: hintStyle ?? AppTextStyles.font12PrimaryRegular,
//           hintText: hintText,
//           suffixIcon: suffixIcon,
//           fillColor: backgroundColor ?? AppColors.lightGray,
//           filled: true,
//         ),
//         obscureText: isObscureText ?? false,
//         style: AppTextStyles.font12PrimaryRegular,
//         validator: (value) {
//           return validator(value);
//         },
//       ),
//     );
//   }
// }
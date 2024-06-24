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
  final String? labelText;
  final double? width;
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
    this.labelText,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.width,
    required this.validator,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width?.w??30),
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
          labelText: labelText,
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

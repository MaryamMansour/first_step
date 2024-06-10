import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  AppTextButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(7),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        fixedSize: MaterialStateProperty.all(Size(250.w, 51.h)),
        backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
      ),
      onPressed:
        onPressed,

      child: Text(
        buttonText,
        style: AppTextStyles.font20WhiteBold,
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../theming/colors.dart';
//
// class AppTextButton extends StatelessWidget {
//   final double? borderRadius;
//   final Color? backgroundColor;
//   final double? horizontalPadding;
//   final double? verticalPadding;
//   final double? buttonWidth;
//   final double? buttonHeight;
//   final String buttonText;
//   final TextStyle textStyle;
//   final VoidCallback onPressed;
//   const AppTextButton({
//     super.key,
//     this.borderRadius,
//     this.backgroundColor,
//     this.horizontalPadding,
//     this.verticalPadding,
//     this.buttonHeight,
//     this.buttonWidth,
//     required this.buttonText,
//     required this.textStyle,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: ButtonStyle(
//         elevation: MaterialStateProperty.all(7),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//           ),
//         ),
//         fixedSize: MaterialStateProperty.all(Size(250.w, 51.h)),
//         backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
//       ),
//       onPressed: onPressed,
//       child: Text(
//         buttonText,
//         style: textStyle,
//       ),
//     );
//   }
// }
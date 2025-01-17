// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../../core/helper/spacing.dart';
// import '../../../../core/theming/colors.dart';
// import '../../../../core/theming/styles.dart';
// import 'dart:io';
// class BuildImageUploadButton extends StatelessWidget {
//   final String label;
//   final XFile? image;
//   final VoidCallback onPressed;
//   const BuildImageUploadButton({super.key, required this.label, this.image, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: onPressed,
//           child: Container(
//             width: 180.w,
//             height: 250.h,
//             decoration: BoxDecoration(
//               boxShadow: [BoxShadow(blurRadius: 2, color: AppColors.gray)],
//               color: AppColors.white,
//               border: Border.all(color: AppColors.lightGray),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: image == null
//                 ? Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
//               child: Column(
//                 children: [
//                   const ImageIcon(
//                     AssetImage("assets/images/logo.png"),
//                     size: 30,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//                     child: Text(
//                       "Logo",
//                       style: AppTextStyles.font15PrimaryBold,
//                     ),
//                   ),
//                   Text(
//                     "Upload High Quality Logo Image",
//                     style: AppTextStyles.font16GrayLight
//                         .copyWith(fontSize: 10),
//                   ),
//                   verticalSpace(10),
//                   Icon(Icons.file_upload_outlined, size: 20),
//                 ],
//               ),
//             )
//                 : Image.file(File(image!.path), fit: BoxFit.cover),
//           ),
//         ),
//       ],
//     );
//   }
// }
//

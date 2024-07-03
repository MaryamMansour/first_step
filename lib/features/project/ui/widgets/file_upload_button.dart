// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../../core/helper/spacing.dart';
// import '../../../../core/theming/colors.dart';
// import '../../../../core/theming/styles.dart';
// import 'dart:io';
//
//
// class BuildFileUploadButton extends StatelessWidget {
//   final  String label;
//   final File? file;
//   final VoidCallback onPressed;
//   const BuildFileUploadButton({super.key, required this.label, this.file, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return   Column(
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
//             child: Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
//               child:
//               file == null
//                   ? Column(
//                 children: [
//                   Icon(Icons.file_copy, size: 30),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//                     child: Text(
//                       "SlideShow",
//                       style: AppTextStyles.font15PrimaryBold,
//                     ),
//                   ),
//                   Text(
//                     "Upload High Quality visuals",
//                     style: AppTextStyles.font16GrayLight.copyWith(fontSize: 10),
//                   ),
//                   verticalSpace(10),
//                   Icon(Icons.file_upload_outlined, size: 20),
//                 ],
//               )
//                   : Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
//
//
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

Future<String?> showUrlInputDialog(BuildContext context, String label) async {
  TextEditingController urlController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter $label URL'),
        content: TextField(
          controller: urlController,
          decoration: InputDecoration(hintText: 'Enter URL here'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(urlController.text);
            },
          ),
        ],
      );
    },
  );
}

class BuildFileUploadButton extends StatefulWidget {
  final String label;

  const BuildFileUploadButton({super.key, required this.label});

  @override
  _BuildFileUploadButtonState createState() => _BuildFileUploadButtonState();
}

class _BuildFileUploadButtonState extends State<BuildFileUploadButton> {
  String? fileUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            String? url = await showUrlInputDialog(context, widget.label);
            if (url != null && url.isNotEmpty) {
              setState(() {
                fileUrl = url;
              });
            }
          },
          child: Container(
            width: 180.w,
            height: 250.h,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 2, color: AppColors.gray)],
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGray),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
              child: fileUrl == null
                  ? Column(
                children: [
                  Icon(Icons.file_copy, size: 30),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Text(
                      widget.label,
                      style: AppTextStyles.font15PrimaryBold,
                    ),
                  ),
                  Text(
                    "Upload High Quality visuals",
                    style: AppTextStyles.font16GrayLight.copyWith(fontSize: 10),
                  ),
                  verticalSpace(10),
                  Icon(Icons.file_upload_outlined, size: 20),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
                  Text(
                    "File URL:",
                    style: AppTextStyles.font16GrayLight,
                  ),
                  Text(
                    fileUrl!,
                    style: AppTextStyles.font15PrimaryBold.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildImageUploadButton extends StatefulWidget {
  final String label;

  const BuildImageUploadButton({super.key, required this.label});

  @override
  _BuildImageUploadButtonState createState() => _BuildImageUploadButtonState();
}

class _BuildImageUploadButtonState extends State<BuildImageUploadButton> {
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            String? url = await showUrlInputDialog(context, widget.label);
            if (url != null && url.isNotEmpty) {
              setState(() {
                imageUrl = url;
              });
            }
          },
          child: Container(
            width: 180.w,
            height: 250.h,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 2, color: AppColors.gray)],
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGray),
              borderRadius: BorderRadius.circular(10),
            ),
            child: imageUrl == null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
              child: Column(
                children: [
                  const ImageIcon(
                    AssetImage("assets/images/logo.png"),
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Text(
                      widget.label,
                      style: AppTextStyles.font15PrimaryBold,
                    ),
                  ),
                  Text(
                    "Upload High Quality Logo Image",
                    style: AppTextStyles.font16GrayLight.copyWith(fontSize: 10),
                  ),
                  verticalSpace(10),
                  Icon(Icons.file_upload_outlined, size: 20),
                ],
              ),
            )
                : Image.network(imageUrl!, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}

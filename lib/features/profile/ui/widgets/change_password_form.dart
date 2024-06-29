import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/app_regex.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../logic/profile_cubit.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          verticalSpace(50),
          AppTextFormField(
            width: 10,
            hintText: "Old Password",
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                )),
            controller: context.read<ProfileCubit>().oldPasswordController,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.hasMinLength(value) ||
                  !AppRegex.hasSpecialCharacter(value) ||
                  !AppRegex.hasNumber(value)) {
                return 'Please enter a valid password';
              }
            },
          ),
          verticalSpace(40),
          AppTextFormField(
            width: 10,
            hintText: "New Password",
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                )),
            controller: context.read<ProfileCubit>().newPasswordController,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.hasMinLength(value) ||
                  !AppRegex.hasSpecialCharacter(value) ||
                  !AppRegex.hasNumber(value)) {
                return 'Please enter a valid password';
              }
            },
          ),
          verticalSpace(50),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileCubit>().resetPassword();
            },
            child: Text("Save",style: AppTextStyles.font20WhiteBold.copyWith(fontSize: 15),),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

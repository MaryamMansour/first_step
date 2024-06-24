import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/styles.dart';

class UserType extends StatefulWidget {
  UserType({super.key});

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  int _value=1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          value: 1,
          groupValue: _value,
          onChanged: (value){
            setState(() {
              _value = value!;
            });
          },
          activeColor: AppColors.primaryColor,
        ),
        Text("Entrepreneur",style: AppTextStyles.font12PrimaryRegular),
        horizontalSpace(40),
        Radio(
          value: 2,
          groupValue: _value,
          onChanged: (value){
            setState(() {
              _value = value!;
            });
          },
          activeColor: AppColors.primaryColor,
        ),
        Text("Investor",style: AppTextStyles.font12PrimaryRegular),
        horizontalSpace(20),
      ],
    ) ;
  }
}

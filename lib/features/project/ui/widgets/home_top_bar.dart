import 'package:first_step/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 453.w,
      height: 220.h,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(70),
        ),
      ),
      child: Column(
        children: [
          verticalSpace(35),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/logo_light.png"),
                ),
              ),
            ],

          ),
          verticalSpace(35),
          FilterButtons(),
          verticalSpace(20),
        ],
      ),
    );
  }
}
class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          FilterButton(text: 'All'),
          FilterButton(text: 'Graduation projects'),
          FilterButton(text: 'Start Ups'),
          IconButton(
            icon: Icon(Icons.tune, color: AppColors.white,),
            onPressed: () {},
          ),
        ]

      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;

  const FilterButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: ElevatedButton(
          onPressed: () {},
          child: Text(text),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ),
    );
  }
}
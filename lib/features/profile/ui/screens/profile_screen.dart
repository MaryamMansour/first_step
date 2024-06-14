import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/features/profile/ui/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

import '../widgets/list_tiles.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Column(
          children: [
            verticalSpace(60),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 49,
                backgroundImage: NetworkImage(
                    'https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-07.jpg'),
              ),
            ),
            verticalSpace(20),
             Text(
              'First Step',
              style: AppTextStyles.font20WhiteBold,
            ),
             Text(
              'FirstStep@example.com',
              style:AppTextStyles.font16GrayLight
            ),
            verticalSpace(20),
            const ListTiles(),

          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

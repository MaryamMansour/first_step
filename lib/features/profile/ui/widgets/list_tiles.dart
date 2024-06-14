import 'package:first_step/core/helper/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/shared_pref.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';

class ListTiles extends StatelessWidget {
  const ListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            verticalSpace(30),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.primaryColor),
              title: const Text('My profile'),
              onTap: () {
                context.pushNamed(Routes.profileDetailsScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.primaryColor),
              title: const Text('Settings'),
              onTap: () {
                //Todo Navigate to Settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: AppColors.primaryColor),
              title: const Text('Share with friends'),
              onTap: () {
                // Share app with friends
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: AppColors.primaryColor),
              title: const Text('Help and support'),
              onTap: () {
                // Navigate to Help and Support
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.primaryColor),
              title: const Text('Log out'),
              onTap: () {
                SharedPrefHelper.clearAllSecuredData();
                SharedPrefHelper.clearAllData();
                context.pushNamed(Routes.loginScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

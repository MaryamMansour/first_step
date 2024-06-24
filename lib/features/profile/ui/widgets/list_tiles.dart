import 'package:first_step/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/routing/routes.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/features/chat/ui/temp_chat.dart';

import '../../../project/ui/screens/upload_screen.dart';

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
              leading: const Icon(Icons.computer_sharp, color: AppColors.primaryColor),
              title: const Text('My Project'),
              onTap: () {
                context.pushNamed(Routes.uploadScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.primaryColor),
              title: const Text('Settings'),
              onTap: () {
                //TODO
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: AppColors.primaryColor),
              title: const Text('Share with friends'),
              onTap: () {
                // TODO Share app with friends
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: AppColors.primaryColor),
              title: const Text('Help and support'),
              onTap: () {
                // TODO Navigate to Help and Support
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.primaryColor),
              title: const Text('Log out'),
              onTap: () async {
                await SharedPrefHelper.clearAllSecuredData();
                await SharedPrefHelper.clearAllData();
                print("Cleared all shared preferences data");
                context.pushNamed(Routes.loginScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

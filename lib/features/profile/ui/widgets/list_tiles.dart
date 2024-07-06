import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/routing/routes.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import 'package:first_step/features/project/data/repo/project_repo.dart';

import '../../../../core/di/depndency_injection.dart';
import '../../../../core/helper/constants.dart';
import '../screens/help_support_screen.dart';
import '../screens/user_projects_screen.dart';

class ListTiles extends StatelessWidget {
  const ListTiles({super.key});

  Future<String> getUserId() async {
    return await SharedPrefHelper.getString(SharedPrefKeys.id) ?? "";
  }

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
              title: const Text('My Projects'),
              onTap: () async {
                String userId = await getUserId();
                int stringUserId = int.parse(userId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) => ProjectCubit(getIt()),
                      child: UserProfileProjectsScreen(userId: stringUserId),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: AppColors.primaryColor),
              title: const Text('Help and support'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpAndSupportScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.primaryColor),
              title: const Text('Log out'),
              onTap: () async {
                await SharedPrefHelper.clearAllSecuredData();
                await SharedPrefHelper.clearAllData();
                context.pushNamed(Routes.loginScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

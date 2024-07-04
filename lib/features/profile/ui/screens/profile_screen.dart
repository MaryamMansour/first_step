import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/features/profile/ui/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

import '../widgets/list_tiles.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;

  void loadUserName() async {
    String? name = await SharedPrefHelper.getString(SharedPrefKeys.fName);
    setState(() {
      userName = name;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Column(
          children: [
            verticalSpace(100),
            if (userName != null)
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  maxRadius: 48,
                  backgroundColor: AppColors.lightGray,
                  child: Text(
                    userName![0].toUpperCase(),
                    style: TextStyle(color: AppColors.primaryColor,
                    fontSize: 25),
                  ),
                ),
              )
            else
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  maxRadius: 25,
                  backgroundColor: AppColors.lightGray,
                  child: Text(
                    "",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
            verticalSpace(40),
            const ListTiles(),
          ],
        ),
      ),
    );
  }
}

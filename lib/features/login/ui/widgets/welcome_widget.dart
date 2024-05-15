import 'package:flutter/material.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/styles.dart';

class WelcomeBackWidget extends StatelessWidget {
  const WelcomeBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        verticalSpace(30),
        Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("Welcome Back!",style: AppTextStyles.font24PrimaryBold,),
                ),
                verticalSpace(5),
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Text("Login to continue in First Step",style: AppTextStyles.font12PrimaryRegular,),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}

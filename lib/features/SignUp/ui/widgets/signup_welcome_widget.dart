import 'package:flutter/cupertino.dart';

import '../../../../core/helper/app_regex.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/text_form_field.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row (

          children: [
            horizontalSpace(20), // space before the image
            Image.asset(width: 100,height: 175,'assets/images/logo_First_Step.png'),
            Column(
              children: [
                verticalSpace(40),
                Text("Your first Step to Success!",style: AppTextStyles.font12PrimaryRegular,),
              ],
            )
          ],
        ),
        Text("Registr Now",style: AppTextStyles.font24PrimaryBold),

      ],
    );
  }
}

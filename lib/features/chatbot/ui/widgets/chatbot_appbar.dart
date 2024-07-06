import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class ChatbotAppbar extends StatelessWidget implements PreferredSizeWidget{
  const ChatbotAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/chatbot.png'), // Replace with your chatbot's image
            backgroundColor: AppColors.primaryColor,
          ),
          SizedBox(width: 10),
          Text('Chat AI',style: AppTextStyles.font20WhiteBold,),
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      leading: IconButton(
        iconSize: 45,
        color: AppColors.white,
        icon: Icon(Icons.arrow_back_ios_new_outlined,size: 20,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
              height: 25,
              width: 25,
              child: Image.asset('assets/images/logo_light.png')),
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

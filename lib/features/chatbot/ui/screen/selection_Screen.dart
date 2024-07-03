import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/features/chatbot/ui/screen/chatbot_screen.dart';
import 'package:first_step/features/chatbot/ui/screen/project_chatbot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Chatbot',style:AppTextStyles.font20WhiteBold),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          iconSize: 45,
          color: AppColors.white,
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
            context.pushNamed(Routes.homeScreen);
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100.h),
         // color: AppColors.lightGreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatbotScreen()),
                  );
                },
                child: Text('Chat with Gemini',style: AppTextStyles.font15PrimaryBold ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProjectChatbot()),
                  );
                },
                child: Text('Chat with OtherBot',style:  AppTextStyles.font15PrimaryBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

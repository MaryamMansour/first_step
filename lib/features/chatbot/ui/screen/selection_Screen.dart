import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/features/chatbot/ui/screen/chatbot_screen.dart';
import 'package:first_step/features/chatbot/ui/screen/project_chatbot.dart';
import 'package:first_step/features/chatbot/ui/widgets/select_chatbot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/depndency_injection.dart';
import '../../../../core/routing/routes.dart';
import '../../../ir-chat/logic/ir_chat_cubit.dart';
import '../../../ir-chat/ui/ir_chat_screen.dart';

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
        title: Text('Select Chatbot', style: AppTextStyles.font20WhiteBold),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          iconSize: 45,
          color: AppColors.white,
          icon: Icon(Icons.arrow_back_ios_new_outlined, size: 20,),
          onPressed: () {
            Navigator.pop(context);
            context.pushNamed(Routes.homeScreen);
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
      ),
      backgroundColor: Color.fromRGBO(250, 252, 251, 1.0),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Welcome to our Chatbot!',
                textAlign: TextAlign.center,
                style: AppTextStyles.font24PrimaryBold,
              ),
              SizedBox(
                height: 250.h,
                width: 250.h,
                child: Image.asset(
                  'assets/images/chatbot.gif',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 100.h),
              SelectChatbot(),
            ],
          ),
        ),
      ),
    );
  }
}

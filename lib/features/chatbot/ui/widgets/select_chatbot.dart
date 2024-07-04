import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/depndency_injection.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../ir-chat/logic/ir_chat_cubit.dart';
import '../../../ir-chat/ui/ir_chat_screen.dart';
import '../screen/chatbot_screen.dart';

class SelectChatbot extends StatelessWidget {
  const SelectChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Card(
            color: AppColors.primaryColor,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    'Ask about business',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font15WhiteBold,
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatbotScreen()),
                      );
                    },
                    child: Text('Start Chat', style: AppTextStyles.font15WhiteBold),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightGray,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Card(
            elevation: 5,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    'Ask about our projects',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font15WhiteBold,
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) => getIt<ProjectChatCubit>(),
                                  child: ProjectChatbot())));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightGray,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                        'Start Chat',
                        style: AppTextStyles.font15WhiteBold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

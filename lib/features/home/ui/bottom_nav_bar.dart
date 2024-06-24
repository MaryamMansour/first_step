import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/colors.dart';
import '../logic/home_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeTab>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.adb_outlined),
              label: 'Chatbot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          currentIndex: HomeTab.values.indexOf(state),
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.gray,
          backgroundColor: Colors.white,
          onTap: (index) {
            final selectedTab = HomeTab.values[index];
            context.read<HomeCubit>().selectTab(selectedTab);
          },
        );
      },
    );
  }
}

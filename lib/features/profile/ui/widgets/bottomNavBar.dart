import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
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
    icon: Icon(Icons.add_circle),
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
    currentIndex: 4,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.gray,
    backgroundColor: Colors.white,
    onTap: (index) {
// Handle tab changes
    },
    );
  }
}

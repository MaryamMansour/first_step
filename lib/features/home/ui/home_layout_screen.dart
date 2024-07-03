import 'package:first_step/features/chatbot/ui/screen/selection_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/depndency_injection.dart';
import '../../chat/ui/chat_screen.dart';
import '../../chatbot/ui/screen/chatbot_screen.dart';
import '../../profile/ui/screens/profile_screen.dart';
import '../../project/logic/project_cubit.dart';
import '../../project/ui/screens/home_page.dart';
import '../../project/ui/screens/project_details.dart';
import '../../project/ui/screens/upload_screen.dart';
import '../logic/home_cubit.dart';
import 'bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeTab>(
          builder: (context, state) {
            switch (state) {
              case HomeTab.home:
                return HomePage();
              case HomeTab.chats:
                return ChatScreen();
              case HomeTab.add:
                return BlocProvider(
                  create: (context) => getIt<ProjectCubit>(),
                  child: UploadProjectScreen(),
                );
              case HomeTab.chatbot:
                return ChatbotPage();
              case HomeTab.account:
                return ProfileScreen();
            }
          },
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}


class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Add Page'));
  }
}

class ChatbotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectionScreen();
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Account Page'));
  }
}

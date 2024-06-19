import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../chat/ui/temp_chat.dart';
import '../../profile/ui/screens/profile_screen.dart';
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
                return AddPage();
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



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home Page'));
  }
}

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Chats Page'));
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
    return Center(child: Text('Chatbot Page'));
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Account Page'));
  }
}

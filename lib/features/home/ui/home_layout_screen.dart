import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../chat/ui/temp_chat.dart';
import '../../profile/ui/screens/profile_screen.dart';
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
                return ProjectDetailsScreen(
                  projectName: 'Shippo',
                  projectDescription:
                      'Popout, Inc. develops mobile software. The Company offers a platform that helps aggregate shipping volumes and giving customers access to cheaper shipping providers.',
                  about:
                      'Shippo is an all-in-one shipping platform that offers real-time carrier rates, automated print labels, and powerful tools that allow businesses to manage their operations more efficiently.',
                  industry: 'Logistics',
                  businessModel: 'SaaS',
                  customerModel: 'B2B',
                  stage: 'Pre Seed',
                  year: '2014',
                  type: 'ST',
                  raisedAmount: '\$25K',
                  legalName: 'Shippo Inc.',
                  slideshowFile:
                      'https://drive.google.com/file/d/1Bx3mK8QhN3E1PkZFD8pBxoEW_fEFcZoX/preview?usp=drivesdk',
                  // replace with actual file
                  logoImage: 'https://logo.clearbit.com/https://zapata.ai',
                  tags: const ['Logistics', 'Transportation', 'Retail'],
                  website: 'goshippo.com',
                  investors: const ['VC'],
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

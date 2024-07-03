import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../../../core/theming/colors.dart';
import 'chatbot_appbar.dart';

class AppDashChat extends StatefulWidget {
  const AppDashChat({super.key});

  @override
  State<AppDashChat> createState() => _AppDashChatState();
}

class _AppDashChatState extends State<AppDashChat> {
  final Gemini gemini = Gemini.instance;
  final TextEditingController _textController = TextEditingController();

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "AI Chat",
    profileImage: "assets/images/chatbot.png",
  );

  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  DashChat(
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages,


        inputOptions: InputOptions(
          alwaysShowSend: false,
          sendButtonBuilder: (function) {
            return IconButton(
              icon: Icon(Icons.send, color: AppColors.primaryColor),
              onPressed: function,
            );
          },
          inputDecoration: InputDecoration(
            hintText: 'Type a message...',
            hintStyle: TextStyle(color: Colors.grey),


            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(50.0),
            ),

            focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(50.0),
            ),

          ),
        ),

        messageOptions: const MessageOptions(
          currentUserContainerColor: AppColors.lightGreen,
          containerColor: AppColors.lightGray,
          currentUserTextColor: Colors.black,
          textColor: Colors.black,
          borderRadius: 30.0,
          showCurrentUserAvatar: false,
          currentUserTimeTextColor: Colors.black,
        ),

      ),
    );
  }


  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
          lastMessage = messages.removeAt(0);

          lastMessage.text += response;

          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";

          ChatMessage message = ChatMessage(user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
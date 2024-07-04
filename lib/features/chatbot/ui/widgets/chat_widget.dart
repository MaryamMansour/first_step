import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

      body:  Center(
        child: DashChat(
          currentUser: currentUser,
          onSend: _sendMessage,
          messages: messages,

          inputOptions: InputOptions(
            inputToolbarPadding: EdgeInsets.only(left: 40.0,bottom: 20.0,right: 20.0),
            alwaysShowSend: true,
            sendButtonBuilder: (function) {
              return Container(
                margin: EdgeInsets.only(left: 5.h),
                decoration: const BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    )),
                child: IconButton(
                  icon: Icon(Icons.send, color: AppColors.white),
                  onPressed: function,
                ),
              );
            },
            inputDecoration: InputDecoration(
              hintText: 'Enter Message...',
              hintStyle: TextStyle(color: Colors.grey),

              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
              ),

              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),

          messageOptions:  MessageOptions(
            currentUserContainerColor: AppColors.primaryColor,
            containerColor: AppColors.gray,
            currentUserTextColor: Colors.white,
            textColor: Colors.black,
            borderRadius: 30.0,
            showCurrentUserAvatar: false,
            currentUserTimeTextColor: Colors.black,
            messageTextBuilder: (ChatMessage message, ChatMessage? previousMessage, ChatMessage? nextMessage) {
              return Text(
                message.text,
                style:  TextStyle(color: Colors.white, fontSize: 16),
              );
            },
          ),
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

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/features/chatbot/ui/widgets/chat_widget.dart';
import 'package:first_step/features/chatbot/ui/widgets/chatbot_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:collection';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatbotAppbar(),
      body: AppDashChat(),
    );
  }
}
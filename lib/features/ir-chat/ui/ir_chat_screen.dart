import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/data/models/project_response.dart';

import '../../../core/di/depndency_injection.dart';
import '../../project/logic/project_cubit.dart';
import '../../project/ui/screens/comment_screen.dart';
import '../../project/ui/widgets/project_card.dart';
import '../../project/ui/widgets/tag_item.dart';
import '../logic/ir_chat_cubit.dart';

class ProjectChatbot extends StatefulWidget {
  const ProjectChatbot({super.key});

  @override
  State<ProjectChatbot> createState() => _ProjectChatbotState();
}

class _ProjectChatbotState extends State<ProjectChatbot> {
  final TextEditingController _queryController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _submitQuery() {
    final query = _queryController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        _messages.add({'type': 'user', 'message': query});
      });
      context.read<ProjectChatCubit>().searchProjects(query);
      _queryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Project Chatbot',
          style: AppTextStyles.font20WhiteBold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ProjectChatCubit, ProjectChatState>(
                listener: (context, state) {
                  if (state is ProjectChatQueryResult) {
                    setState(() {
                      _messages.add({'type': 'bot', 'message': state.projects});
                    });
                  } else if (state is ProjectChatError) {
                    setState(() {
                      _messages.add({'type': 'bot', 'message': state.message});
                    });
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      if (message['type'] == 'user') {
                        return _buildUserMessage(message['message']);
                      } else if (message['type'] == 'bot') {
                        if (message['message'] is List<ProjectResponse>) {
                          return _buildBotProjectsMessage(message['message']);
                        }
                      }
                      return SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _queryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _submitQuery,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(

          margin: EdgeInsets.symmetric(vertical: 5.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(message),
        ),
      ),
    );
  }

  Widget _buildBotProjectsMessage(List<ProjectResponse> projects) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.lightGray,
              backgroundImage: AssetImage("assets/images/chatbot.png"),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              projects.map((project) => ProjectCard(project: project)).toList(),
        ),
      ],
    );
  }
}

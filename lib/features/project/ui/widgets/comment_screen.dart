import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import 'package:first_step/features/project/logic/project_state.dart';

class CommentsScreen extends StatefulWidget {
  final int projectId;

  const CommentsScreen({Key? key, required this.projectId}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  void _submitComment() {
    final content = _commentController.text.trim();
    if (content.isNotEmpty) {
      context.read<ProjectCubit>().addComment(widget.projectId, content);
      _commentController.clear();

      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment added successfully!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ProjectCubit>().getComments(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        toolbarHeight: 100,
        title: Text('Comments'),
      ),
      body: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    commentsLoading: () => Center(child: CircularProgressIndicator()),
                    commentsSuccess: (comments) {
                      if (comments.isEmpty) {
                        return Center(child: Text("There are no comments yet."));
                      }
                      return ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    maxRadius: 25,
                                    backgroundColor: AppColors.lightGray,
                                    child: Text(comment.userName[0].toUpperCase(),
                                    style: TextStyle(color: AppColors.primaryColor),),
                                  ),
                                  title: Text(
                                    comment.userName,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(comment.content),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Divider(
                                  thickness: 0.5,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    commentsError: (errorHandler) => Center(child: Text("Failed to load comments")),
                    orElse: () => Container(),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: "Add a comment",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _submitComment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}


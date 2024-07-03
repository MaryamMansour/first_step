import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import 'package:first_step/features/project/logic/project_state.dart';




class CommentsSection extends StatefulWidget {
  final int projectId;
  const CommentsSection({Key? key, required this.projectId}) : super(key: key);

  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _commentController = TextEditingController();

  void _submitComment() {
    final content = _commentController.text.trim();
    if (content.isNotEmpty) {
      context.read<ProjectCubit>().addComment(widget.projectId, content);
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.25,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                BlocBuilder<ProjectCubit, ProjectState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      commentsLoading: () => Center(child: CircularProgressIndicator()),
                      commentsSuccess: (comments) {
                        if (comments.isEmpty) {
                          return Center(child: Text("There are no comments yet."));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return ListTile(
                              title: Text(comment.content),
                              subtitle: Text(comment.userName),
                            );
                          },
                        );
                      },
                      commentsError: (errorHandler) => Center(child: Text("Failed to load comments")),
                      orElse: () => Container(),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            labelText: "Add a comment",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _submitComment,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
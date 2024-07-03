import 'package:dio/dio.dart';
import 'package:first_step/core/di/depndency_injection.dart';
import 'package:flutter/material.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import '../../logic/project_state.dart';
import '../screens/project_details.dart';
import 'comment_section.dart';
import 'tag_item.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'tag_item.dart';

class ProjectsListView extends StatefulWidget {
  final List<ProjectResponse?>? projectList;

  const ProjectsListView({Key? key, required this.projectList}) : super(key: key);

  @override
  _ProjectsListViewState createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  late ScrollController _scrollController;
  Set<int> _expandedProjects = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9 &&
        !_scrollController.position.outOfRange) {
      BlocProvider.of<ProjectCubit>(context).loadMoreProjects();
    }
  }

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedProjects.contains(index)) {
        _expandedProjects.remove(index);
      } else {
        _expandedProjects.add(index);
      }
    });
  }

  void _showCommentsModal(int projectId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<ProjectCubit>(context),
          child: CommentsSection(projectId: projectId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.projectList?.length ?? 0,
      itemBuilder: (context, index) {
        final project = widget.projectList![index];
        final isExpanded = _expandedProjects.contains(index);

        return Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectDetailsScreen(
                    projectName: project?.companyName ?? '',
                    projectDescription: project?.slogan ?? '',
                    about: project?.about ?? '',
                    industry: project?.industry ?? '',
                    businessModel: project?.businessModel ?? '',
                    customerModel: project?.customerModel ?? '',
                    stage: project?.stage ?? '',
                    year: project?.year ?? '',
                    type: project?.type ?? '',
                    legalName: project?.legalName ?? '',
                    slideshowFile: project?.pdfURL,
                    logoImage: project?.imageURL,
                    tags: project?.tags?.split(',').map((tag) => tag.trim()).toList() ?? [],
                    website: project?.website ?? '',
                    raisedAmount: project?.amountRaised ?? '',
                    investors: project?.investors?.split(',').map((investor) => investor.trim()).toList() ?? [],
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _buildImage(project?.imageURL),
                          ),
                          verticalSpace(10),
                          if (project?.tags != null && project!.tags!.isNotEmpty)
                            Wrap(
                              spacing: 2.0,
                              runSpacing: 3.0,
                              children: [
                                ...?project.tags?.split(',').take(2).map((tag) {
                                  return TagItem(text: tag.trim());
                                }).toList(),
                              ],
                            ),
                          verticalSpace(20),
                          InkWell(
                            onTap: () => _showCommentsModal(project?.projectID ?? 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("${project?.comments.length.toString()} Comments", style: AppTextStyles.font12Blacklight.copyWith(fontSize: 8),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    horizontalSpace(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project?.companyName ?? '',
                            style: AppTextStyles.font20BlackThin.copyWith(
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace(15),
                          Text(
                            "Description: ${project?.slogan ?? ''}",
                            style: AppTextStyles.font16PrimaryLight,
                            overflow: TextOverflow.ellipsis,
                            maxLines: isExpanded ? null : 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Divider(
                height: 0.7,
                thickness: 0.5,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImage(String? url) {
    if (url == null || url.isEmpty || !Uri.parse(url).hasAbsolutePath) {
      return Image.network(
        'https://lightwidget.com/wp-content/uploads/localhost-file-not-found.jpg',
        height: 120.h,
        width: 180.w,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      url,
      height: 120.h,
      width: 180.w,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.network(
          'https://lightwidget.com/wp-content/uploads/localhost-file-not-found.jpg',
          height: 120.h,
          width: 180.w,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

// widgets/comments_section.dart


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

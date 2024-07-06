import 'package:dio/dio.dart';
import 'package:first_step/core/di/depndency_injection.dart';
import 'package:flutter/material.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/core/helper/spacing.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import '../../logic/project_state.dart';
import '../screens/project_details.dart';
import '../screens/comment_screen.dart';
import 'tag_item.dart';
import 'package:first_step/core/helper/shared_pref.dart';

class ProjectsListView extends StatefulWidget {
  final List<ProjectResponse?>? projectList;

  const ProjectsListView({Key? key, required this.projectList})
      : super(key: key);

  @override
  _ProjectsListViewState createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  late ScrollController _scrollController;
  Set<int> _expandedProjects = {};
  int? userId;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    String? tempId = await SharedPrefHelper.getString(SharedPrefKeys.id);
    userId = int.parse(tempId ?? '0');
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9 &&
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

  void _navigateToCommentsScreen(int projectId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<ProjectCubit>(),
              child: CommentsScreen(
                projectId: projectId,
              ),
            )));
  }

  void _likeProject(int? projectId) {
    context.read<ProjectCubit>().likeProject(projectId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final projectList = state.maybeWhen(
          projectsSuccess: (projects) => projects,
          orElse: () => widget.projectList,
        );

        return ListView.builder(
          controller: _scrollController,
          itemCount: projectList?.length ?? 0,
          itemBuilder: (context, index) {
            final project = projectList![index];
            final isExpanded = _expandedProjects.contains(index);

            return Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => getIt<ProjectCubit>(),
                        child: ProjectDetailsScreen(
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
                          userId: project?.user?.id.toString() ?? '',
                          userName: project?.user?.firstName ?? '',
                        ),
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
                              verticalSpace(20),
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
                                style: AppTextStyles.font20BlackThin.copyWith(fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(15),
                              Text(
                                "Description: ${project?.slogan ?? ''}",
                                style: AppTextStyles.font16PrimaryLight,
                                overflow: TextOverflow.ellipsis,
                                maxLines: isExpanded ? null : 3,
                              ),
                              verticalSpace(40),
                              Row(
                                children: [
                                Expanded(
                                  child: Row(children: [  Text(
                                    '${project?.year} ● ${project?.stage}',
                                    style: AppTextStyles.font16GrayLight.copyWith(
                                        fontSize: 10, color: AppColors.gray, fontWeight: FontWeight.w400),
                                  ),

                                    const Icon(
                                      Icons.stairs_outlined,
                                      size: 10,
                                      color: AppColors.gray,
                                    ),],),
                                ),

                                ],

                              ),
                              verticalSpace(10),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => _navigateToCommentsScreen(project?.projectID ?? 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Comments",
                                            style: AppTextStyles.font12Blacklight.copyWith(
                                                fontSize: 10, color: AppColors.primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => _likeProject(project.projectID),
                                      child: Row(
                                        children: [
                                          Icon(
                                            project!.likes.contains(userId)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: project.likes.contains(userId) ? Colors.red : Colors.grey,
                                            size: 20,
                                          ),
                                          horizontalSpace(5),
                                          Text(
                                            "${project.numberOfLikes ?? 0} likes",
                                            style: AppTextStyles.font12Blacklight.copyWith(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: Divider(
                    height: 0.7,
                    thickness: 0.5,
                  ),
                ),
              ],
            );
          },
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

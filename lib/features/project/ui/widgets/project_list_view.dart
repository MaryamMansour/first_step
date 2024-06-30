// projects_list_view.dart
import 'package:flutter/material.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import '../screens/project_details.dart';
import 'tag_item.dart';

class ProjectsListView extends StatefulWidget {
  final List<ProjectResponse?>? projectList;

  const ProjectsListView({super.key, required this.projectList});

  @override
  _ProjectsListViewState createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  late ScrollController _scrollController;
  Set<int> _expandedProjects = {}; // Track which projects are expanded

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.projectList?.length ?? 0,
      itemBuilder: (context, index) {
        final project = widget.projectList![index];
        final isExpanded = _expandedProjects.contains(index);

        return GestureDetector(
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
                tags: project?.tags.split(',').map((tag) => tag.trim()).toList() ?? [],
                website: project?.website ?? '',
                raisedAmount: project?.amountRaised ?? '',
                investors: project?.investors.split(',').map((investor) => investor.trim()).toList() ?? [],
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
                      // Display tags with "More" if there are more than 3
                      if (project?.tags != null && project!.tags.isNotEmpty)
                        Wrap(
                          spacing: 2.0,
                          runSpacing: 3.0,
                          children: [
                            ...project.tags.split(',').take(2).map((tag) {
                              return TagItem(text: tag.trim());
                            }).toList(),
                          ],
                        ),
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
        );
      },
    );
  }

  Widget _buildImage(String? url) {
    if (url == null || url.isEmpty || !Uri.parse(url).hasAbsolutePath) {
      return Image.network(
        'https://lightwidget.com/wp-content/uploads/localhost-file-not-found.jpg', // Path to your default image
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
          'https://lightwidget.com/wp-content/uploads/localhost-file-not-found.jpg', // Path to your default image
          height: 120.h,
          width: 180.w,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

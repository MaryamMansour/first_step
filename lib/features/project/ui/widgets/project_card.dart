
import 'package:flutter/material.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/core/helper/spacing.dart';
import '../../../../core/di/depndency_injection.dart';
import '../../logic/project_cubit.dart';
import '../screens/project_details.dart';
import 'comment_screen.dart';
import 'tag_item.dart';

class ProjectCard extends StatelessWidget {
  final ProjectResponse project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsScreen(
                projectName: project.companyName ?? '',
                projectDescription: project.slogan ?? '',
                about: project.about ?? '',
                industry: project.industry ?? '',
                businessModel: project.businessModel ?? '',
                customerModel: project.customerModel ?? '',
                stage: project.stage ?? '',
                year: project.year ?? '',
                type: project.type ?? '',
                legalName: project.legalName ?? '',
                slideshowFile: project.pdfURL,
                logoImage: project.imageURL,
                tags: project.tags?.split(',').map((tag) => tag.trim()).toList() ?? [],
                website: project.website ?? '',
                raisedAmount: project.amountRaised ?? '',
                investors: project.investors?.split(',').map((investor) => investor.trim()).toList() ?? [],
                userId: project.user?.id.toString() ?? '',
                userName: project.user?.firstName ?? '',
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
                        child: _buildImage(project.imageURL),
                      ),
                      verticalSpace(10),
                      if (project.tags != null && project.tags!.isNotEmpty)
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
                        onTap: () => _navigateToCommentsScreen(context, project.projectID ?? 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Comments",
                                style: AppTextStyles.font12Blacklight.copyWith(fontSize: 8)),
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
                        project.companyName ?? '',
                        style: AppTextStyles.font20BlackThin.copyWith(fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(15),
                      Text(
                        "Description: ${project.slogan ?? ''}",
                        style: AppTextStyles.font16PrimaryLight,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
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

  void _navigateToCommentsScreen(BuildContext context, int projectId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<ProjectCubit>(),
          child: CommentsScreen(projectId: projectId),
        ),
      ),
    );
  }
}

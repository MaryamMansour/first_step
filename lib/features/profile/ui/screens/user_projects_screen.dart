import 'package:first_step/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import 'package:first_step/features/project/logic/project_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/depndency_injection.dart';
import '../../../../core/helper/spacing.dart';
import '../../../project/ui/screens/upload_screen.dart';
import '../../../project/ui/screens/project_details.dart';

class UserProfileProjectsScreen extends StatefulWidget {
  final int userId;

  const UserProfileProjectsScreen({required this.userId});

  @override
  _UserProfileProjectsScreenState createState() => _UserProfileProjectsScreenState();
}

class _UserProfileProjectsScreenState extends State<UserProfileProjectsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectCubit>().getProjectsByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('My Projects', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          return state.maybeWhen(
            projectsSuccess: (projects) {
              return ListView.builder(
                itemCount: projects?.length ?? 0,
                itemBuilder: (context, index) {
                  final project = projects![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
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
                            userId: project?.user?.id.toString() ?? '',
                            userName: project?.user?.firstName ?? '',
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project?.companyName ?? '',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  verticalSpace(10),
                                  Text(
                                    project?.slogan ?? '',
                                    style: TextStyle(fontSize: 14.0),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  verticalSpace(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: AppColors.primaryColor),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => BlocProvider(
                                                create: (context) => ProjectCubit(getIt()),
                                                child: UploadProjectScreen(project: project),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () async {
                                          final confirm = await showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Delete Project'),
                                                content: Text(
                                                    'Are you sure you want to delete this project?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, true),
                                                    child: Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          if (confirm == true) {
                                            context.read<ProjectCubit>().deleteProject(project?.projectID ?? 1);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: _buildImage(project?.imageURL),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            projectsLoading: () => Center(child: CircularProgressIndicator()),
            projectsError: (errorHandler) => Center(child: Text('Error: ${errorHandler.apiErrorModel.message}')),
            orElse: () => Center(child: Text('No projects found')),
          );
        },
      ),
    );
  }

  Widget _buildImage(String? url) {
    if (url == null || url.isEmpty || !Uri.parse(url).hasAbsolutePath) {
      return Image.network(
        'https://lightwidget.com/wp-content/uploads/localhost-file-not-found.jpg',
        height: 100.h,
        width: 100.h,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      url,
      height: 100.h,
      width: 100.h,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.network(
          'https://lightwidget.com/wp-content/uploads/localhost-file-not-found.jpg',
          height: 100.h,
          width: 100.h,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

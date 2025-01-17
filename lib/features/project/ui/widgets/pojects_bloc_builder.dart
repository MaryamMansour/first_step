import 'package:first_step/features/project/ui/widgets/project_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import 'package:first_step/features/project/logic/project_state.dart';
import 'package:first_step/features/project/ui/widgets/projects_shimmer_loading.dart';

class ProjectsBlocBuilder extends StatelessWidget {
  const ProjectsBlocBuilder({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const SizedBox.shrink(),
          projectsLoading: () => const ProjectsShimmerLoading(),
          projectsSuccess: (projectList) => Expanded(child: ProjectsListView(projectList: projectList)),
          projectsLoadingMore: (projectList) => Expanded(
            child: Column(
              children: [
                Expanded(child: ProjectsListView(projectList: projectList)),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),

          projectsError: (errorHandler) => const Center(child: Text("Failed to load projects")),
          orElse: () {
            print("Unknown state: $state");
            return const Center(child: Text("Unknown state"));
          },
        );
      },
    );
  }
}

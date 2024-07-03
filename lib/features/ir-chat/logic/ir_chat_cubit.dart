import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/core/networking/api_result.dart';
import 'package:first_step/features/project/data/models/project_response.dart';

import '../data/repo/ir_chat_repo.dart';

abstract class ProjectChatState {}

class ProjectChatInitial extends ProjectChatState {}

class ProjectChatLoading extends ProjectChatState {}

class ProjectChatError extends ProjectChatState {
  final String message;
  ProjectChatError(this.message);
}

class ProjectChatQueryResult extends ProjectChatState {
  final List<ProjectResponse> projects;
  ProjectChatQueryResult(this.projects);
}

class ProjectChatCubit extends Cubit<ProjectChatState> {
  final ProjectChatRepo _projectChatRepo;

  ProjectChatCubit(this._projectChatRepo) : super(ProjectChatInitial());

  void searchProjects(String query) async {
    emit(ProjectChatLoading());
    final result = await _projectChatRepo.searchProjects(query);
    result.when(
      success: (projectIds) async {
        final projects = <ProjectResponse>[];
        for (final id in projectIds) {
          final projectResult = await _projectChatRepo.getProjectById(id);
          projectResult.when(
            success: (project) {
              projects.add(project);
            },
            failure: (errorHandler) {
              emit(ProjectChatError(errorHandler.apiErrorModel?.message??""));
            },
          );
        }
        emit(ProjectChatQueryResult(projects));
      },
      failure: (errorHandler) {
        emit(ProjectChatError(errorHandler.apiErrorModel?.message??""));
      },
    );
  }}

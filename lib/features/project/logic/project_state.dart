// project_state.dart
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:first_step/core/networking/api_error_handler.dart';

part 'project_state.freezed.dart';

@freezed
class ProjectState with _$ProjectState {
  const factory ProjectState.initial() = _Initial;
  const factory ProjectState.projectsLoading() = _ProjectsLoading;
  const factory ProjectState.projectsSuccess(List<ProjectResponse?>? projects) = _ProjectsSuccess;
  const factory ProjectState.projectsError(ErrorHandler errorHandler) = _ProjectsError;
  const factory ProjectState.projectsLoadingMore(List<ProjectResponse?>? projects) = _ProjectsLoadingMore;
  const factory ProjectState.projectUploadSuccess(ProjectResponse project) = _ProjectUploadSuccess;

}
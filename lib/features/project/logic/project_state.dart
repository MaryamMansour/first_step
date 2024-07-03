// project_state.dart
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:first_step/features/project/data/models/project_upload_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:first_step/core/networking/api_error_handler.dart';

import '../data/models/comment_model.dart';

part 'project_state.freezed.dart';

@freezed
class ProjectState with _$ProjectState {
  const factory ProjectState.initial() = _Initial;
  const factory ProjectState.projectsLoading() = _ProjectsLoading;
  const factory ProjectState.projectsSuccess(List<ProjectResponse?>? projects) = _ProjectsSuccess;
  const factory ProjectState.projectsError(ErrorHandler errorHandler) = _ProjectsError;
  const factory ProjectState.projectsLoadingMore(List<ProjectResponse?>? projects) = _ProjectsLoadingMore;
  const factory ProjectState.projectUploadSuccess(ProjectUploadResponse project) = _ProjectUploadSuccess;

  const factory ProjectState.commentsLoading() = _CommentsLoading;
  const factory ProjectState.commentsSuccess(List<CommentResponse> comments) = _CommentsSuccess;
  const factory ProjectState.commentsError(ErrorHandler errorHandler) = _CommentsError;
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:first_step/features/project/data/repo/project_repo.dart';
import 'package:first_step/features/project/logic/project_state.dart';
import '../data/models/comment_model.dart';
import '../data/models/project_upload_request_body.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepo _projectRepo;
  bool isDataLoaded = false;

  ProjectCubit(this._projectRepo) : super(ProjectState.initial());

  List<ProjectResponse?>? allProjects = [];
  List<ProjectResponse?>? displayedProjects = [];
  final int _pageSize = 20;
  int _currentPage = 0;
  bool _isLoadingMore = false;

  void getAllProjects() async {
    if (isDataLoaded) {
      emit(ProjectState.projectsSuccess(displayedProjects));
      return;
    }

    emit(const ProjectState.projectsLoading());
    final response = await _projectRepo.getAllProjects();
    response.when(
      success: (projectResponse) {
        allProjects = projectResponse;
        _currentPage = 0;
        displayedProjects = [];
        _loadNextPage();
        isDataLoaded = true;
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }

  void _loadNextPage() {
    if (_isLoadingMore || allProjects == null || allProjects!.isEmpty) return;
    _isLoadingMore = true;

    final nextPageItems = allProjects!.skip(_currentPage * _pageSize).take(_pageSize).toList();
    displayedProjects = [...displayedProjects!, ...nextPageItems];
    _currentPage++;
    emit(ProjectState.projectsSuccess(displayedProjects));

    _isLoadingMore = false;
  }

  void loadMoreProjects() {
    if (_isLoadingMore || displayedProjects?.length == allProjects?.length) {
      return;
    }
    emit(ProjectState.projectsLoadingMore(displayedProjects));
    _loadNextPage();
  }

  void searchProjects(String query) async {
    emit(const ProjectState.projectsLoading());
    final response = await _projectRepo.searchProjects(query);
    response.when(
      success: (projectResponse) {
        displayedProjects = projectResponse;
        emit(ProjectState.projectsSuccess(displayedProjects));
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }

  void uploadProject(ProjectUploadRequestBody projectRequestBody) async {
    emit(const ProjectState.projectsLoading());
    final response = await _projectRepo.uploadProject(projectRequestBody);
    response.when(
      success: (projectUploadResponse) {
        emit(ProjectState.projectUploadSuccess(projectUploadResponse));
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }

  void filterProjectsByType(String type) {
    emit(const ProjectState.projectsLoading());
    final filteredProjects = allProjects?.where((project) => project?.type == type).toList();
    displayedProjects = filteredProjects;
    emit(ProjectState.projectsSuccess(filteredProjects));
  }

  void getComments(int projectId) async {
    emit(ProjectState.commentsLoading());
    final response = await _projectRepo.getComments(projectId);
    response.when(
      success: (commentsResponse) {
        emit(ProjectState.commentsSuccess(commentsResponse));
      },
      failure: (errorHandler) {
        emit(ProjectState.commentsError(errorHandler));
      },
    );
  }

  void addComment(int projectId, String content) async {
    final addCommentRequest = AddCommentRequest(content: content);
    final response = await _projectRepo.addComment(projectId, addCommentRequest);
    response.when(
      success: (commentResponse) {
        state.maybeWhen(
          commentsSuccess: (comments) {
            final updatedComments = List<CommentResponse>.from(comments)..add(commentResponse);
            emit(ProjectState.commentsSuccess(updatedComments));
          },
          orElse: () {
            getComments(projectId);
          },
        );
      },
      failure: (errorHandler) {
        emit(ProjectState.commentsError(errorHandler));
      },
    );
  }

  void getProjectsByUserId(int userId) async {
    emit(const ProjectState.projectsLoading());
    final response = await _projectRepo.getProjectsByUserId(userId);
    response.when(
      success: (projectResponse) {
        allProjects = projectResponse;
        emit(ProjectState.projectsSuccess(projectResponse));
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }

  void updateProject(int projectId, ProjectUploadRequestBody projectRequestBody) async {
    emit(const ProjectState.projectsLoading());
    final response = await _projectRepo.updateProject(projectId, projectRequestBody);
    response.when(
      success: (projectUploadResponse) {
        emit(ProjectState.projectUploadSuccess(projectUploadResponse));
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }

  void deleteProject(int projectId) async {
    emit(const ProjectState.projectsLoading());
    final response = await _projectRepo.deleteProject(projectId);
    response.when(
      success: (_) {
        allProjects = allProjects?.where((project) => project?.projectID != projectId).toList();
        displayedProjects = displayedProjects?.where((project) => project?.projectID != projectId).toList();
        emit(ProjectState.projectsSuccess(allProjects));
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }

  void likeProject(int projectId) async {
    final response = await _projectRepo.likeProject(projectId);
    response.when(
      success: (projectResponse) {
        final updatedProjects = allProjects?.map((project) {
          if (project?.projectID == projectId) {
            return project?.copyWith(
              likes: projectResponse.data?.likes ?? [],
              numberOfLikes: projectResponse.data?.numberOfLikes,
            );
          }
          return project;
        }).toList();

        final updatedDisplayedProjects = displayedProjects?.map((project) {
          if (project?.projectID == projectId) {
            return project?.copyWith(
              likes: projectResponse.data?.likes ?? [],
              numberOfLikes: projectResponse.data?.numberOfLikes,
            );
          }
          return project;
        }).toList();

        allProjects = updatedProjects;
        displayedProjects = updatedDisplayedProjects;
        emit(ProjectState.projectsSuccess(displayedProjects));
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }
}

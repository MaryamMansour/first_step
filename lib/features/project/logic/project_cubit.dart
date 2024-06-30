// project_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:first_step/features/project/data/repo/project_repo.dart';
import 'package:first_step/features/project/logic/project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepo _projectRepo;
  bool isFetchingMore = false;
  bool isDataLoaded = false; // Add a flag to check if data is already loaded

  ProjectCubit(this._projectRepo) : super(ProjectState.initial());

  List<ProjectResponse?>? allProjects = [];
  List<ProjectResponse?>? displayedProjects = [];
  final int _pageSize = 20; // Number of items per page
  int _currentPage = 0;

  void getAllProjects() async {
    if (isDataLoaded) {
      // If data is already loaded, emit the cached data
      emit(ProjectState.projectsSuccess(displayedProjects));
      return;
    }

    emit(const ProjectState.projectsLoading());
    final response = await _projectRepo.getAllProjects();
    response.when(
      success: (projectResponse) {
        allProjects = projectResponse;
        displayedProjects = [];
        _currentPage = 0; // Reset current page
        _loadNextPage();
        isDataLoaded = true; // Set the flag to true after loading data
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }

  void _loadNextPage() {
    if (allProjects != null && allProjects!.isNotEmpty) {
      final nextPageItems = allProjects!.skip(_currentPage * _pageSize).take(_pageSize).toList();
      displayedProjects = [...displayedProjects!, ...nextPageItems]; // Append new items
      _currentPage++;
      emit(ProjectState.projectsSuccess(displayedProjects));
    }
  }

  void loadMoreProjects() {
    if (isFetchingMore || displayedProjects?.length == allProjects?.length) {
      return;
    }
    isFetchingMore = true;
    emit(ProjectState.projectsLoadingMore(displayedProjects));
    Future.delayed(Duration(seconds: 1), () {
      _loadNextPage();
      isFetchingMore = false;
    });
  }
}

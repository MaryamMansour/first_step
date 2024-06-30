import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:first_step/features/project/data/repo/project_repo.dart';
import 'package:first_step/features/project/logic/project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepo _projectRepo;
  bool isDataLoaded = false;

  ProjectCubit(this._projectRepo) : super(ProjectState.initial());

  List<ProjectResponse?>? allProjects = [];
  List<ProjectResponse?>? displayedProjects = [];
  final int _pageSize = 20;
  int _currentPage = 0;

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
        _loadNextPage();
        isDataLoaded = true;
      },
      failure: (errorHandler) {
        emit(ProjectState.projectsError(errorHandler));
      },
    );
  }

  void _loadNextPage() {
    if (allProjects != null && allProjects!.isNotEmpty) {
      final nextPageItems = allProjects!.skip(_currentPage * _pageSize).take(_pageSize).toList();
      displayedProjects = [...displayedProjects!, ...nextPageItems];
      _currentPage++;
      emit(ProjectState.projectsSuccess(displayedProjects));
    }
  }

  void loadMoreProjects() {
    if (displayedProjects?.length == allProjects?.length) {
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
}
// project_repo.dart
import 'package:first_step/core/networking/api_service.dart';
import 'package:first_step/core/networking/api_result.dart';
import 'package:first_step/core/networking/api_error_handler.dart';
import 'package:first_step/features/project/data/models/project_response.dart';

class ProjectRepo {
  final ApiService _apiService;

  ProjectRepo(this._apiService);

  Future<ApiResult<List<ProjectResponse>>> getAllProjects() async {
    try {
      final response = await _apiService.getAllProjects();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}

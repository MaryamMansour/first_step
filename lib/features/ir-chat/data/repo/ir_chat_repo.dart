import 'package:first_step/core/networking/api_service.dart';
import 'package:first_step/core/networking/api_result.dart';
import 'package:first_step/core/networking/api_error_handler.dart';
import 'package:first_step/features/project/data/models/project_response.dart';

class ProjectChatRepo {
  final ApiService _apiService;

  ProjectChatRepo(this._apiService);

  Future<ApiResult<List<int>>> searchProjects(String query) async {
    try {
      final response = await _apiService.irSearchProjects(query);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ProjectResponse>> getProjectById(int id) async {
    try {
      final response = await _apiService.getProjectById(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}

import 'package:first_step/core/networking/api_service.dart';
import 'package:first_step/core/networking/api_result.dart';
import 'package:first_step/core/networking/api_error_handler.dart';
import 'package:first_step/features/project/data/models/project_response.dart';

import '../models/project_upload_request_body.dart';

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

  Future<ApiResult<List<ProjectResponse>>> searchProjects(String query) async {
    try {
      final response = await _apiService.searchProjects(query);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }



  Future<ApiResult<ProjectResponse>> uploadProject(ProjectUploadRequestBody projectRequestBody) async {
    try {
      final response = await _apiService.uploadProject(projectRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}

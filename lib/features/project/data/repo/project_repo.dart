import 'package:first_step/core/networking/api_service.dart';
import 'package:first_step/core/networking/api_result.dart';
import 'package:first_step/core/networking/api_error_handler.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:first_step/features/project/data/models/project_upload_response.dart';
import '../models/comment_model.dart';
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

  Future<ApiResult<List<ProjectResponse>>> getProjectsByUserId(int userId) async {
    try {
      final response = await _apiService.getProjectsByUserId(userId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ProjectUploadResponse>> updateProject(int projectId, ProjectUploadRequestBody projectRequestBody) async {
    try {
      final response = await _apiService.updateProject(projectId, projectRequestBody);
      if (response != null) {
        return ApiResult.success(response);
      } else {
        return ApiResult.failure(ErrorHandler.handle("Null response received"));
      }
    } catch (error) {
      print("Update project error: ${error.toString()}");
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<CommentResponse>>> getComments(int projectId) async {
    try {
      final response = await _apiService.getComments(projectId);
      return ApiResult.success(response);
    } catch (error) {
      print(ErrorHandler.handle(error));
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }


  Future<ApiResult<CommentResponse>> addComment(int projectId, AddCommentRequest addCommentRequest) async {
    try {
      final response = await _apiService.addComment(projectId, addCommentRequest);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ProjectUploadResponse>> uploadProject(ProjectUploadRequestBody projectRequestBody) async {
    try {
      final response = await _apiService.uploadProject(projectRequestBody);
      print(response.message);
      return ApiResult.success(response);
    } catch (error) {
      print("DioError: ${error}");

      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteProject(int projectId) async {
    try {
      await _apiService.deleteProject(projectId);
      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }


  Future<ApiResult<ProjectUploadResponse>> likeProject(int projectId) async {
    try {
      final response = await _apiService.likeProject(projectId);
      if (response != null) {
        return ApiResult.success(response);
      } else {
        return ApiResult.failure(ErrorHandler.handle("Null response received"));
      }
    } catch (error) {
      print("REPO");
      print(error.toString());
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
}

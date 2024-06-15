import 'package:first_step/features/profile/data/models/profile_request_body.dart';
import 'package:first_step/features/profile/data/models/profile_response.dart';
import 'package:first_step/features/profile/data/models/reset_password_request_body.dart';
import 'package:first_step/features/profile/data/models/reset_password_response.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class ProfileApiRepo {

  final ApiService _apiService;
  ProfileApiRepo(this._apiService);


  Future<ApiResult<ProfileResponse>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ProfileResponse>> updateProfile(ProfileRequestBody profileRequestBody) async {
    try {
      final response = await _apiService.updateProfile(profileRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  Future<ApiResult<ResetPasswordResponse>> resetPassword(ResetPasswordRequestBody resetPasswordRequestBody) async {
    try {
      final response = await _apiService.resetPassword(resetPasswordRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

}


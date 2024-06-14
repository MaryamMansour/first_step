import 'package:first_step/features/profile/data/models/profile_response.dart';

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

}


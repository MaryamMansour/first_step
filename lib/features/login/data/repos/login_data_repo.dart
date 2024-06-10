import 'package:first_step/features/login/data/models/login_request_body.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/login_response.dart';

abstract class LoginDomainRepo
{
  Future<ApiResult<LoginResponse>>login(LoginRequestBody loginRequestBody);
}

class LoginApiRepo implements LoginDomainRepo{

  final ApiService _apiService;
  LoginApiRepo(this._apiService);
  @override
  Future<ApiResult<LoginResponse>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

}


import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../model/sign_up_request_body.dart';
import '../model/sign_up_response.dart';

class SignupRepo {
  final ApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignupResponse>> signup(
      SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiService.signup(signupRequestBody);
      print('api success');
      return ApiResult.success(response);
    } catch (error) {
      print('api failure');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
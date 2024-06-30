import 'package:dio/dio.dart';
import 'package:first_step/features/profile/data/models/profile_request_body.dart';
import 'package:retrofit/http.dart';
import '../../features/SignUp/data/model/sign_up_request_body.dart';
import '../../features/SignUp/data/model/sign_up_response.dart';
import '../../features/login/data/models/login_request_body.dart';
import '../../features/login/data/models/login_response.dart';
import '../../features/profile/data/models/profile_response.dart';
import '../../features/profile/data/models/reset_password_request_body.dart';
import '../../features/profile/data/models/reset_password_response.dart';
import '../../features/project/data/models/project_response.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
      @Body() LoginRequestBody loginRequestBody,
      );

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(
      @Body() SignupRequestBody signupRequestBody,
      );

  @GET(ApiConstants.profile)
  Future<ProfileResponse> getProfile();

  @PUT(ApiConstants.profile)
  Future<ProfileResponse> updateProfile(
      @Body() ProfileRequestBody profileRequestBody
      );

  @PUT(ApiConstants.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
      @Body() ResetPasswordRequestBody resetPasswordRequestBody
      );

  @GET(ApiConstants.getAllProjects)
  Future<List<ProjectResponse>> getAllProjects();

  @GET("project/search/{query}")
  Future<List<ProjectResponse>> searchProjects(@Path("query") String query);
}

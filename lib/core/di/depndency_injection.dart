import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:first_step/core/networking/api_service.dart';
import 'package:first_step/core/networking/dio_factory.dart';
import 'package:first_step/features/login/data/repos/login_data_repo.dart';
import 'package:first_step/features/profile/data/repos/profile_repo.dart';
import 'package:first_step/features/project/data/repo/project_repo.dart';
import 'package:first_step/features/login/logic/cubit/login_cubit.dart';
import 'package:first_step/features/profile/logic/profile_cubit.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import '../../features/SignUp/data/repos/sign_up_repo.dart';
import '../../features/SignUp/logic/cubit/sign_up_cubit.dart';
import '../../features/ir-chat/data/repo/ir_chat_repo.dart';
import '../../features/ir-chat/logic/ir_chat_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = await DioFactory.getDio();  // Ensure async initialization
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginApiRepo>(() => LoginApiRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt()));

  // profile
  getIt.registerLazySingleton<ProfileApiRepo>(() => ProfileApiRepo(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt(), getIt()));

  // project
  getIt.registerLazySingleton<ProjectRepo>(() => ProjectRepo(getIt()));
  getIt.registerFactory<ProjectCubit>(() => ProjectCubit(getIt()));


  // ir chat
  getIt.registerLazySingleton<ProjectChatRepo>(() => ProjectChatRepo(getIt()));
  getIt.registerFactory<ProjectChatCubit>(() => ProjectChatCubit(getIt()));
}

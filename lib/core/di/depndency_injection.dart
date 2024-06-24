import 'package:dio/dio.dart';
import 'package:first_step/features/login/data/repos/login_data_repo.dart';
import 'package:first_step/features/profile/data/repos/profile_repo.dart';
import 'package:first_step/features/profile/logic/profile_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/SignUp/data/repos/sign_up_repo.dart';
import '../../features/SignUp/logic/cubit/sign_up_cubit.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginApiRepo>(() => LoginApiRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt()));


  //profile
  getIt.registerLazySingleton<ProfileApiRepo>(() => ProfileApiRepo(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

}
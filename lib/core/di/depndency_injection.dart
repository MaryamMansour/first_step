import 'package:dio/dio.dart';
import 'package:first_step/features/login/data/repos/login_data_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/logic/cubit/login_cubit.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginDomainRepo>(() => LoginApiRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));


}
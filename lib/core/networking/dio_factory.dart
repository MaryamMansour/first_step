import 'package:dio/dio.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helper/shared_pref.dart';

class DioFactory {
  /// private constructor
  DioFactory._();

  static Dio? dio;

  static Dio getDio() { /// (Singleton)
    Duration timeOut = const Duration(seconds: 40);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization':
      'Bearer ${await SharedPrefHelper.getString(SharedPrefKeys.userToken) }',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
    };
  }


  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
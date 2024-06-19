import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/networking/dio_factory.dart';
import 'package:first_step/features/login/data/repos/login_data_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/firestore_service.dart';
import '../../../profile/data/repos/profile_repo.dart';
import '../../data/models/login_request_body.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginApiRepo _loginRepo;
  final ProfileApiRepo _profileApiRepo;

  LoginCubit(this._loginRepo, this._profileApiRepo)
      : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());

    // First response
    final response = await _loginRepo.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    // Handle first response
    await response.when(success: (loginResponse) async {
      await saveUserToken(
        loginResponse.userData?.token ?? '',
        loginResponse.userData?.email ?? '',
      );

      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });

    // Second response
    final responseTwo = await _profileApiRepo.getProfile();

    // Handle second response
    await responseTwo.when(
      success: (profileResponse) async {
        await saveUserId(
          profileResponse.data?.id.toString() ?? "",
          profileResponse.data?.email ?? "",
          profileResponse.data?.firstName??""
        );

        print("TEST ${profileResponse.data?.id.toString()}");

        FireStoreServices.addUser(
          profileResponse.data!.id.toString(),
          profileResponse.data?.userName ?? "",
          profileResponse.data?.email ?? "",
          profileResponse.data?.firstName ?? "",
          profileResponse.data?.lastName ?? "",
        );
      },
      failure: (error) {
        // Handle error if needed
      },
    );
  }


  Future<void> saveUserToken(String token, String email) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    await SharedPrefHelper.setData(SharedPrefKeys.email, email);

    DioFactory.setTokenIntoHeaderAfterLogin(token);
    //  print(SharedPrefHelper.getString(SharedPrefKeys.userToken));
  }

  Future<void> saveUserId(String id, String email, String fName) async {
    await SharedPrefHelper.setData(SharedPrefKeys.id, id);
    await SharedPrefHelper.setData(SharedPrefKeys.email, email);
    await SharedPrefHelper.setData(SharedPrefKeys.fName, fName);
  }
}

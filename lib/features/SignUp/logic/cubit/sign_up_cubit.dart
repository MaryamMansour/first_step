
import 'package:first_step/features/SignUp/logic/cubit/sign_up_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/sign_up_request_body.dart';
import '../../data/repos/sign_up_repo.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignupCubit(this._signupRepo) : super(const SignupState.initial());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitSignupStates() async {
    emit(const SignupState.signupLoading());
    final response = await _signupRepo.signup(
      SignupRequestBody(
        firstName: firstNameController.text,
        lastName: secondNameController.text,
        userName: userNameController.text,
        email: emailController.text,
        password: passwordController.text,

      ),
    );
    response.when(success: (signupResponse) {
      print("aaaaaaaaaaaaa");
      emit(SignupState.signupSuccess(signupResponse));

    }, failure: (error) {
      print('bbbbbbbbbb');
      emit(SignupState.signupError(error: error.apiErrorModel.message ?? ''));
    });
  }
}
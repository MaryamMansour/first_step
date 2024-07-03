
import 'package:first_step/features/SignUp/logic/cubit/sign_up_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/constants.dart';
import '../../../../core/helper/shared_pref.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../../core/networking/firestore_service.dart';
import '../../../profile/data/repos/profile_repo.dart';
import '../../data/model/sign_up_request_body.dart';
import '../../data/repos/sign_up_repo.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  final ProfileApiRepo _profileApiRepo;

  SignupCubit(this._signupRepo, this._profileApiRepo) : super(const SignupState.initial());

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
    await response.when(success: (signupResponse) async{
      await saveUserToken(
      signupResponse.userData?.token ?? '',
      signupResponse.userData?.email ?? '',
      );

      emit(SignupState.signupSuccess(signupResponse));

    }, failure: (error) {
      emit(SignupState.signupError(error: error.apiErrorModel.message ?? ''));
    });

    final responseTwo = await _profileApiRepo.getProfile();

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
}}
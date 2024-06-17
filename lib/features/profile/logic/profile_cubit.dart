import 'package:first_step/features/profile/data/models/profile_request_body.dart';
import 'package:first_step/features/profile/data/models/profile_response.dart';
import 'package:first_step/features/profile/data/models/reset_password_request_body.dart';
import 'package:first_step/features/profile/data/repos/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileApiRepo _profileApiRepo;

  ProfileCubit(this._profileApiRepo) : super(const ProfileState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  void getProfile() async {
    emit(const ProfileState.profileLoading());
    final response = await _profileApiRepo.getProfile();
    response.when(
      success: (profileResponse) {
        emit(ProfileState.profileSuccess(profileResponse));
      },
      failure: (errorHandler) {
        emit(ProfileState.profileError(errorHandler));
      },
    );
  }

  void updateProfile() async {
    emit(const ProfileState.profileLoading());
    final response = await _profileApiRepo.updateProfile(ProfileRequestBody(
        firstName: firstNameController.text,
        email: emailController.text,
        lastName: lastNameController.text,
        userName: userNameController.text));
    response.when(success: (profileResponse) async {
      emit(ProfileState.profileSuccess(profileResponse));
    }, failure: (error) {
      emit(ProfileState.profileError(error));
    });
  }

  void resetPassword() async {
    emit(const ProfileState.profileLoading());
    final response =
        await _profileApiRepo.resetPassword(ResetPasswordRequestBody(
      currentPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
    ));
    response.when(success: (resetPasswordResponse) async {
      emit(ProfileState.resetSuccess(resetPasswordResponse));
    }, failure: (error) {
      emit(ProfileState.profileError(error));
    });
  }
}

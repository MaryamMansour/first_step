import 'package:first_step/features/profile/data/models/profile_response.dart';
import 'package:first_step/features/profile/data/repos/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileApiRepo _profileApiRepo;
  ProfileCubit(this._profileApiRepo) : super(const ProfileState.initial());

  void getProfile() async {
    emit(const ProfileState.profileLoading());
    final response = await _profileApiRepo.getProfile();
    response.when(
      success: (profileResponse) {
        print("HI CUBIT");
        print(profileResponse.data?.firstName??"F");
        emit(ProfileState.profileSuccess(profileResponse));
      },
      failure: (errorHandler) {
        emit(ProfileState.profileError(errorHandler));
      },
    );
  }
}
import 'package:first_step/features/profile/data/models/profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/networking/api_error_handler.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  const factory ProfileState.profileLoading() = profileLoading;
  const factory ProfileState.profileSuccess(ProfileResponse profileResponse) = profileSuccess;
  const factory ProfileState.profileError(ErrorHandler errorHandler) =
  profileError;
}
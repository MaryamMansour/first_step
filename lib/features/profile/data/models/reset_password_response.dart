import 'package:json_annotation/json_annotation.dart';
part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  String? message;

  ResetPasswordResponse(this.message);

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);
}


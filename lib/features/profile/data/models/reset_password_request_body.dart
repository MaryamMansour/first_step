import 'package:json_annotation/json_annotation.dart';
part 'reset_password_request_body.g.dart';

@JsonSerializable()
class ResetPasswordRequestBody {
  String? currentPassword;
  String? newPassword;
  ResetPasswordRequestBody({this.newPassword,this.currentPassword});

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);

}


import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? message;
  int? code;
  // @JsonKey(name: 'data') // in case api key doesn't match with variable
  String? token;
  String? email;


  LoginResponse({this.message, this.token, this.email, this.code});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;



  SignupRequestBody({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,

  });

  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}
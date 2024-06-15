import 'package:json_annotation/json_annotation.dart';
part 'profile_request_body.g.dart';

@JsonSerializable()
class ProfileRequestBody {
  String? firstName;
  String? lastName;
  String? email;
  String? userName;
  ProfileRequestBody({this.firstName,this.lastName,this.email,this.userName});

  Map<String, dynamic> toJson() => _$ProfileRequestBodyToJson(this);

}


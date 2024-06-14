import 'package:json_annotation/json_annotation.dart';
part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  String? message;
  Data? data;

  ProfileResponse(this.data,this.message);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}



@JsonSerializable()
class Data{
  String? firstName;
  String? lastName;
  String? email;
  String? userName;

  Data(this.firstName,this.lastName, this.email, this.userName);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
}
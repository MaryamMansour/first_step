// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileRequestBody _$ProfileRequestBodyFromJson(Map<String, dynamic> json) =>
    ProfileRequestBody(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$ProfileRequestBodyToJson(ProfileRequestBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'userName': instance.userName,
    };

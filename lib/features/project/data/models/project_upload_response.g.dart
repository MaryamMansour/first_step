// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectUploadResponse _$ProjectUploadResponseFromJson(
        Map<String, dynamic> json) =>
    ProjectUploadResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ProjectData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectUploadResponseToJson(
        ProjectUploadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ProjectData _$ProjectDataFromJson(Map<String, dynamic> json) => ProjectData(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      companyName: json['companyName'] as String?,
      slogan: json['slogan'] as String?,
      amountRaised: json['amountRaised'] as String?,
      year: json['year'] as String?,
      stage: json['stage'] as String?,
      businessModel: json['businessModel'] as String?,
      fullDescription: json['fullDescription'] as String?,
      imageURL: json['imageURL'] as String?,
      pdf_URL: json['pdf_URL'] as String?,
      investors: json['investors'] as String?,
      about: json['about'] as String?,
      industry: json['industry'] as String?,
      tags: json['tags'] as String?,
      customerModel: json['customerModel'] as String?,
      website: json['website'] as String?,
      legalName: json['legalName'] as String?,
      type: json['type'] as String?,
      projectID: (json['projectID'] as num?)?.toInt(),
      numberOfLikes: (json['numberOfLikes'] as num?)?.toInt(),
      likes: (json['likes'] as List<dynamic>).map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$ProjectDataToJson(ProjectData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'companyName': instance.companyName,
      'slogan': instance.slogan,
      'amountRaised': instance.amountRaised,
      'year': instance.year,
      'stage': instance.stage,
      'businessModel': instance.businessModel,
      'fullDescription': instance.fullDescription,
      'imageURL': instance.imageURL,
      'pdf_URL': instance.pdf_URL,
      'investors': instance.investors,
      'about': instance.about,
      'industry': instance.industry,
      'tags': instance.tags,
      'customerModel': instance.customerModel,
      'website': instance.website,
      'legalName': instance.legalName,
      'type': instance.type,
      'projectID': instance.projectID,
      'numberOfLikes': instance.numberOfLikes,
      'likes': instance.likes,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
    };

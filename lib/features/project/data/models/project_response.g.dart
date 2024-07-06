// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectResponse _$ProjectResponseFromJson(Map<String, dynamic> json) =>
    ProjectResponse(
      projectID: (json['projectID'] as num?)?.toInt(),
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
      pdfURL: json['pdf_URL'] as String?,
      investors: json['investors'] as String?,
      about: json['about'] as String?,
      industry: json['industry'] as String?,
      tags: json['tags'] as String?,
      customerModel: json['customerModel'] as String?,
      website: json['website'] as String?,
      legalName: json['legalName'] as String?,
      type: json['type'] as String?,
      likes: (json['likes'] as List<dynamic>)
          .map((e) => (e as num?)?.toInt())
          .toList(),
      numberOfLikes: (json['numberOfLikes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProjectResponseToJson(ProjectResponse instance) =>
    <String, dynamic>{
      'projectID': instance.projectID,
      'user': instance.user,
      'companyName': instance.companyName,
      'slogan': instance.slogan,
      'amountRaised': instance.amountRaised,
      'year': instance.year,
      'stage': instance.stage,
      'businessModel': instance.businessModel,
      'fullDescription': instance.fullDescription,
      'imageURL': instance.imageURL,
      'pdf_URL': instance.pdfURL,
      'investors': instance.investors,
      'about': instance.about,
      'industry': instance.industry,
      'tags': instance.tags,
      'customerModel': instance.customerModel,
      'website': instance.website,
      'legalName': instance.legalName,
      'type': instance.type,
      'likes': instance.likes,
      'numberOfLikes': instance.numberOfLikes,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
    };

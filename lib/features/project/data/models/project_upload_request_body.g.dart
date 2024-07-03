// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_upload_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectUploadRequestBody _$ProjectUploadRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ProjectUploadRequestBody(
      companyName: json['companyName'] as String?,
      slogan: json['slogan'] as String?,
      amountRaised: json['amountRaised'] as String?,
      year: json['year'] as String?,
      stage: json['stage'] as String?,
      businessModel: json['businessModel'] as String?,
      imageURL: json['imageURL'] as String?,
      fullDescription: json['fullDescription'] as String?,
      pdfURL: json['pdfURL'] as String?,
      investors: json['investors'] as String?,
      about: json['about'] as String?,
      industry: json['industry'] as String?,
      tags: json['tags'] as String?,
      customerModel: json['customerModel'] as String?,
      website: json['website'] as String?,
      legalName: json['legalName'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ProjectUploadRequestBodyToJson(
        ProjectUploadRequestBody instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'slogan': instance.slogan,
      'amountRaised': instance.amountRaised,
      'year': instance.year,
      'stage': instance.stage,
      'businessModel': instance.businessModel,
      'imageURL': instance.imageURL,
      'fullDescription': instance.fullDescription,
      'pdfURL': instance.pdfURL,
      'investors': instance.investors,
      'about': instance.about,
      'industry': instance.industry,
      'tags': instance.tags,
      'customerModel': instance.customerModel,
      'website': instance.website,
      'legalName': instance.legalName,
      'type': instance.type,
    };

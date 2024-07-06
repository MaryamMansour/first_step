import 'package:json_annotation/json_annotation.dart';

part 'project_upload_response.g.dart';

@JsonSerializable()
class ProjectUploadResponse {
  final String? status;
  final String? message;
  final ProjectData? data;

  ProjectUploadResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProjectUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectUploadResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectUploadResponseToJson(this);
}

@JsonSerializable()
class ProjectData {
  final User? user;
  final String? companyName;
  final String? slogan;
  final String? amountRaised;
  final String? year;
  final String? stage;
  final String? businessModel;
  final String? fullDescription;
  final String? imageURL;
  final String? pdf_URL;
  final String? investors;
  final String? about;
  final String? industry;
  final String? tags;
  final String? customerModel;
  final String? website;
  final String? legalName;
  final String? type;
  final int? projectID;
  final int? numberOfLikes;
  final List<int>? likes;

  ProjectData({
    required this.user,
    required this.companyName,
    required this.slogan,
    required this.amountRaised,
    required this.year,
    required this.stage,
    required this.businessModel,
    required this.fullDescription,
    required this.imageURL,
    required this.pdf_URL,
    required this.investors,
    required this.about,
    required this.industry,
    required this.tags,
    required this.customerModel,
    required this.website,
    required this.legalName,
    required this.type,
    required this.projectID,
    required this.numberOfLikes,
    required this.likes,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) =>
      _$ProjectDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectDataToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String userName;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'project_response.g.dart';

@JsonSerializable()
class ProjectResponse {
  final int? projectID;
  final User? user;
  final String? companyName;
  final String? slogan;
  final String? amountRaised;
  final String? year;
  final String? stage;
  final String? businessModel;
  final String? fullDescription;
  final String? imageURL;
  @JsonKey(name: 'pdf_URL')
  final String? pdfURL;
  final String? investors;
  final String? about;
  final String? industry;
  final String? tags;
  final String? customerModel;
  final String? website;
  final String? legalName;
  final String? type;
  @JsonKey(name: 'likes')
  final List<String?> comments;
  final int? numberOfLikes;

  ProjectResponse({
    required this.projectID,
    required this.user,
    required this.companyName,
    required this.slogan,
    required this.amountRaised,
    required this.year,
    required this.stage,
    required this.businessModel,
    required this.fullDescription,
    required this.imageURL,
    required this.pdfURL,
    required this.investors,
    required this.about,
    required this.industry,
    required this.tags,
    required this.customerModel,
    required this.website,
    required this.legalName,
    required this.type,
    required this.comments,
    required this.numberOfLikes,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectResponseToJson(this);
}


@JsonSerializable()
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String userName;
  User({
   required this.id,
   required this.email,
   required this.firstName,
   required this.lastName,
   required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}


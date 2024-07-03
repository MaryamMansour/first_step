import 'package:json_annotation/json_annotation.dart';

part 'project_upload_request_body.g.dart';

@JsonSerializable()
class ProjectUploadRequestBody {
  final String? companyName;
  final String? slogan;
  final String? amountRaised;
  final String? year;
  final String? stage;
  final String? businessModel;
  final String? imageURL;
  final String? fullDescription;
  final String? pdfURL;
  final String? investors;
  final String? about;
  final String? industry;
  final String? tags;
  final String? customerModel;
  final String? website;
  final String? legalName;
  final String? type;

  ProjectUploadRequestBody({
    required this.companyName,
    required this.slogan,
    required this.amountRaised,
    required this.year,
    required this.stage,
    required this.businessModel,
    required this.imageURL,
    required this.fullDescription,
    required this.pdfURL,
    required this.investors,
    required this.about,
    required this.industry,
    required this.tags,
    required this.customerModel,
    required this.website,
    required this.legalName,
    required this.type,
  });

  factory ProjectUploadRequestBody.fromJson(Map<String, dynamic> json) => _$ProjectUploadRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectUploadRequestBodyToJson(this);
}

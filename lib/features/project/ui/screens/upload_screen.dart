import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/data/models/project_upload_request_body.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/project_state.dart';

class UploadProjectScreen extends StatefulWidget {
  @override
  _UploadProjectScreenState createState() => _UploadProjectScreenState();
}

class _UploadProjectScreenState extends State<UploadProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _sloganController = TextEditingController();
  final TextEditingController _amountRaisedController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _stageController = TextEditingController();
  final TextEditingController _businessModelController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _fullDescriptionController = TextEditingController();
  final TextEditingController _pdfURLController = TextEditingController();
  final TextEditingController _investorsController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _customerModelController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _legalNameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Project')),
      body: BlocListener<ProjectCubit, ProjectState>(
        listener: (context, state) {
          state.maybeWhen(
            projectUploadSuccess: (project) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Project uploaded successfully!')),
              );
            },
            orElse: () {},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _companyNameController,
                  decoration: InputDecoration(labelText: 'Company Name'),
                ),
                TextFormField(
                  controller: _sloganController,
                  decoration: InputDecoration(labelText: 'Slogan'),
                ),
                TextFormField(
                  controller: _amountRaisedController,
                  decoration: InputDecoration(labelText: 'Amount Raised'),
                ),
                TextFormField(
                  controller: _yearController,
                  decoration: InputDecoration(labelText: 'Year'),
                ),
                TextFormField(
                  controller: _stageController,
                  decoration: InputDecoration(labelText: 'Stage'),
                ),
                TextFormField(
                  controller: _businessModelController,
                  decoration: InputDecoration(labelText: 'Business Model'),
                ),
                BuildImageUploadButton(
                  label: 'Image URL',
                  onPressed: () async {
                    String? url = await showUrlInputDialog(context, 'Image');
                    if (url != null && url.isNotEmpty) {
                      _imageURLController.text = url;
                    }
                  },
                ),
                TextFormField(
                  controller: _fullDescriptionController,
                  decoration: InputDecoration(labelText: 'Full Description'),
                ),
                BuildFileUploadButton(
                  label: 'PDF URL',
                  onPressed: () async {
                    String? url = await showUrlInputDialog(context, 'PDF');
                    if (url != null && url.isNotEmpty) {
                      _pdfURLController.text = url;
                    }
                  },
                ),
                TextFormField(
                  controller: _investorsController,
                  decoration: InputDecoration(labelText: 'Investors'),
                ),
                TextFormField(
                  controller: _aboutController,
                  decoration: InputDecoration(labelText: 'About'),
                ),
                TextFormField(
                  controller: _industryController,
                  decoration: InputDecoration(labelText: 'Industry'),
                ),
                TextFormField(
                  controller: _tagsController,
                  decoration: InputDecoration(labelText: 'Tags'),
                ),
                TextFormField(
                  controller: _customerModelController,
                  decoration: InputDecoration(labelText: 'Customer Model'),
                ),
                TextFormField(
                  controller: _websiteController,
                  decoration: InputDecoration(labelText: 'Website'),
                ),
                TextFormField(
                  controller: _legalNameController,
                  decoration: InputDecoration(labelText: 'Legal Name'),
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(labelText: 'Type'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final projectRequestBody = ProjectUploadRequestBody(
                        companyName: _companyNameController.text,
                        slogan: _sloganController.text,
                        amountRaised: _amountRaisedController.text,
                        year: _yearController.text,
                        stage: _stageController.text,
                        businessModel: _businessModelController.text,
                        imageURL: _imageURLController.text,
                        fullDescription: _fullDescriptionController.text,
                        pdfURL: _pdfURLController.text,
                        investors: _investorsController.text,
                        about: _aboutController.text,
                        industry: _industryController.text,
                        tags: _tagsController.text,
                        customerModel: _customerModelController.text,
                        website: _websiteController.text,
                        legalName: _legalNameController.text,
                        type: _typeController.text,
                      );

                      context.read<ProjectCubit>().uploadProject(projectRequestBody);
                    }
                  },
                  child: Text('Upload Project'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String?> showUrlInputDialog(BuildContext context, String label) async {
  TextEditingController urlController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter $label URL'),
        content: TextField(
          controller: urlController,
          decoration: InputDecoration(hintText: 'Enter URL here'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(urlController.text);
            },
          ),
        ],
      );
    },
  );
}

class BuildFileUploadButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;


  const BuildFileUploadButton({super.key, required this.label, required this.onPressed});

  @override
  _BuildFileUploadButtonState createState() => _BuildFileUploadButtonState();
}

class _BuildFileUploadButtonState extends State<BuildFileUploadButton> {
  String? fileUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            String? url = await showUrlInputDialog(context, widget.label);
            if (url != null && url.isNotEmpty) {
              setState(() {
                fileUrl = url;
              });
            }
          },
          child: Container(
            width: 180.w,
            height: 250.h,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 2, color: AppColors.gray)],
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGray),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
              child: fileUrl == null
                  ? Column(
                children: [
                  Icon(Icons.file_copy, size: 30),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Text(
                      widget.label,
                      style: AppTextStyles.font15PrimaryBold,
                    ),
                  ),
                  Text(
                    "Upload High Quality visuals",
                    style: AppTextStyles.font16GrayLight.copyWith(fontSize: 10),
                  ),
                  verticalSpace(10),
                  Icon(Icons.file_upload_outlined, size: 20),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
                  Text(
                    "File URL:",
                    style: AppTextStyles.font16GrayLight,
                  ),
                  Text(
                    fileUrl!,
                    style: AppTextStyles.font15PrimaryBold.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildImageUploadButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;


  const BuildImageUploadButton({super.key, required this.label, required this.onPressed});

  @override
  _BuildImageUploadButtonState createState() => _BuildImageUploadButtonState();
}

class _BuildImageUploadButtonState extends State<BuildImageUploadButton> {
  String? imageUrl;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            String? url = await showUrlInputDialog(context, widget.label);
            if (url != null && url.isNotEmpty) {
              setState(() {
                imageUrl = url;
              });
            }
          },
          child: Container(
            width: 180.w,
            height: 250.h,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 2, color: AppColors.gray)],
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGray),
              borderRadius: BorderRadius.circular(10),
            ),
            child: imageUrl == null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
              child: Column(
                children: [
                  const ImageIcon(
                    AssetImage("assets/images/logo.png"),
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Text(
                      widget.label,
                      style: AppTextStyles.font15PrimaryBold,
                    ),
                  ),
                  Text(
                    "Upload High Quality Logo Image",
                    style: AppTextStyles.font16GrayLight.copyWith(fontSize: 10),
                  ),
                  verticalSpace(10),
                  Icon(Icons.file_upload_outlined, size: 20),
                ],
              ),
            )
                : Image.network(imageUrl!, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}

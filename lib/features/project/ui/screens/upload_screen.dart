import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/features/project/data/models/project_upload_request_body.dart';
import 'package:first_step/features/project/data/models/project_response.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/project_state.dart';
import '../../../../core/helper/shared_pref.dart';

class UploadProjectScreen extends StatefulWidget {
  final ProjectResponse? project;

  const UploadProjectScreen({this.project});

  @override
  _UploadProjectScreenState createState() => _UploadProjectScreenState();
}

class _UploadProjectScreenState extends State<UploadProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
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
  void initState() {
    super.initState();
    if (widget.project != null) {
      _loadProjectData(widget.project!);
    } else {
      _loadSavedData();
    }
  }

  Future<void> _loadSavedData() async {
    _companyNameController.text = await SharedPrefHelper.getString('companyName') ?? '';
    _sloganController.text = await SharedPrefHelper.getString('slogan') ?? '';
    _amountRaisedController.text = await SharedPrefHelper.getString('amountRaised') ?? '';
    _yearController.text = await SharedPrefHelper.getString('year') ?? '';
    _stageController.text = await SharedPrefHelper.getString('stage') ?? '';
    _businessModelController.text = await SharedPrefHelper.getString('businessModel') ?? '';
    _imageURLController.text = await SharedPrefHelper.getString('imageURL') ?? '';
    _fullDescriptionController.text = await SharedPrefHelper.getString('fullDescription') ?? '';
    _pdfURLController.text = await SharedPrefHelper.getString('pdfURL') ?? '';
    _investorsController.text = await SharedPrefHelper.getString('investors') ?? '';
    _aboutController.text = await SharedPrefHelper.getString('about') ?? '';
    _industryController.text = await SharedPrefHelper.getString('industry') ?? '';
    _tagsController.text = await SharedPrefHelper.getString('tags') ?? '';
    _customerModelController.text = await SharedPrefHelper.getString('customerModel') ?? '';
    _websiteController.text = await SharedPrefHelper.getString('website') ?? '';
    _legalNameController.text = await SharedPrefHelper.getString('legalName') ?? '';
    _typeController.text = await SharedPrefHelper.getString('type') ?? '';
  }

  void _loadProjectData(ProjectResponse project) {
    _companyNameController.text = project.companyName ?? '';
    _sloganController.text = project.slogan ?? '';
    _amountRaisedController.text = project.amountRaised ?? '';
    _yearController.text = project.year ?? '';
    _stageController.text = project.stage ?? '';
    _businessModelController.text = project.businessModel ?? '';
    _imageURLController.text = project.imageURL ?? '';
    _fullDescriptionController.text = project.fullDescription ?? '';
    _pdfURLController.text = project.pdfURL ?? '';
    _investorsController.text = project.investors ?? '';
    _aboutController.text = project.about ?? '';
    _industryController.text = project.industry ?? '';
    _tagsController.text = project.tags ?? '';
    _customerModelController.text = project.customerModel ?? '';
    _websiteController.text = project.website ?? '';
    _legalNameController.text = project.legalName ?? '';
    _typeController.text = project.type ?? '';
  }

  Future<void> _saveDraft() async {
    await SharedPrefHelper.setData('companyName', _companyNameController.text);
    await SharedPrefHelper.setData('slogan', _sloganController.text);
    await SharedPrefHelper.setData('amountRaised', _amountRaisedController.text);
    await SharedPrefHelper.setData('year', _yearController.text);
    await SharedPrefHelper.setData('stage', _stageController.text);
    await SharedPrefHelper.setData('businessModel', _businessModelController.text);
    await SharedPrefHelper.setData('imageURL', _imageURLController.text);
    await SharedPrefHelper.setData('fullDescription', _fullDescriptionController.text);
    await SharedPrefHelper.setData('pdfURL', _pdfURLController.text);
    await SharedPrefHelper.setData('investors', _investorsController.text);
    await SharedPrefHelper.setData('about', _aboutController.text);
    await SharedPrefHelper.setData('industry', _industryController.text);
    await SharedPrefHelper.setData('tags', _tagsController.text);
    await SharedPrefHelper.setData('customerModel', _customerModelController.text);
    await SharedPrefHelper.setData('website', _websiteController.text);
    await SharedPrefHelper.setData('legalName', _legalNameController.text);
    await SharedPrefHelper.setData('type', _typeController.text);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(30),
              Container(
                decoration: BoxDecoration(color: AppColors.white),
                child: Row(
                  children: [
                    horizontalSpace(20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.project == null ? "Upload Project" : "Update Project",
                        style: AppTextStyles.font12BlackBold.copyWith(fontSize: 24),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        height: 50,
                        width: 50,
                        'assets/images/logo_dark.png',
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: AppColors.white),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: BuildUrlInputButton(
                                label: 'PDF URL',
                                controller: _pdfURLController,
                                onPressed: () async {
                                  String? url = await showUrlInputDialog(context, 'PDF');
                                  if (url != null && url.isNotEmpty) {
                                    _pdfURLController.text = url;
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: BuildUrlInputButton(
                                label: 'Image URL',
                                controller: _imageURLController,
                                onPressed: () async {
                                  String? url = await showUrlInputDialog(context, 'Image');
                                  if (url != null && url.isNotEmpty) {
                                    _imageURLController.text = url;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _companyNameController,
                          decoration: InputDecoration(labelText: 'Company Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter company name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _sloganController,
                          maxLines: 3,
                          decoration: InputDecoration(labelText: 'Slogan'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter slogan';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _amountRaisedController,
                          decoration: InputDecoration(labelText: 'Amount Raised'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter amount raised';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _yearController,
                          decoration: InputDecoration(labelText: 'Year'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter year';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _stageController,
                          decoration: InputDecoration(labelText: 'Stage'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter stage';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _businessModelController,
                          decoration: InputDecoration(labelText: 'Business Model'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter business model';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          maxLines: 4,
                          controller: _fullDescriptionController,
                          decoration: InputDecoration(labelText: 'Full Description'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter full description';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _investorsController,
                          decoration: InputDecoration(labelText: 'Investors'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter investors';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _aboutController,
                          maxLines: 3,
                          decoration: InputDecoration(labelText: 'About'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter about';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _industryController,
                          decoration: InputDecoration(labelText: 'Industry'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter industry';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _tagsController,
                          decoration: InputDecoration(labelText: 'Tags'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter tags';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _customerModelController,
                          decoration: InputDecoration(labelText: 'Customer Model'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter customer model';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _websiteController,
                          decoration: InputDecoration(labelText: 'Website'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter website';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _legalNameController,
                          decoration: InputDecoration(labelText: 'Legal Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter legal name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _typeController,
                          decoration: InputDecoration(labelText: 'Type'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter type';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                              ),
                              onPressed: _saveDraft,
                              child: Text('Save Draft', style: AppTextStyles.font20WhiteBold.copyWith(fontSize: 12)),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  DioFactory.setTokenIntoHeaderAfterLogin(
                                    await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken),
                                  );
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

                                  if (widget.project == null) {
                                    context.read<ProjectCubit>().uploadProject(projectRequestBody);
                                  } else {
                                    print("projectRequestBody: $projectRequestBody");
                                    context.read<ProjectCubit>().updateProject(widget.project!.projectID ?? 0, projectRequestBody);
                                  }
                                }
                              },
                              child: Text(
                                widget.project == null ? 'Upload Project' : 'Update Project',
                                style: AppTextStyles.font20WhiteBold.copyWith(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildUrlInputButton extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onPressed;

  const BuildUrlInputButton({
    Key? key,
    required this.label,
    required this.controller,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
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
              child: controller.text.isEmpty
                  ? Column(
                children: [
                  Icon(Icons.file_copy, size: 30),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Text(
                      label,
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
                  Icon(Icons.file_present, size: 50, color: AppColors.primaryColor),
                  SizedBox(height: 8),
                  Text(
                    "$label URL Set",
                    style: AppTextStyles.font16GrayLight,
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

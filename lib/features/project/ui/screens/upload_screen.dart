import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../core/helper/shared_pref.dart';
import '../widgets/file_upload_button.dart';
import '../widgets/image_upload_button.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final picker = ImagePicker();
  File? slideshowFile;
  XFile? logoImage;

  final TextEditingController projectDescriptionController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController sloganController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController serialNameController = TextEditingController();
  final TextEditingController raisedWhereController = TextEditingController();

  String? industry;
  String? businessModel;
  String? customerModel;
  String? stage;

  List<String> industryOptions = [
    'Select Industry',
    'Option 1',
    'Option 2',
    'Option 3'
  ];
  List<String> businessModelOptions = [
    'Select Business Model',
    'Option 1',
    'Option 2',
    'Option 3'
  ];
  List<String> customerModelOptions = [
    'Select Customer Model',
    'Option 1',
    'Option 2',
    'Option 3'
  ];
  List<String> stageOptions = [
    'Select Stage',
    'Option 1',
    'Option 2',
    'Option 3'
  ];

  @override
  void initState() {
    super.initState();
    industry = industryOptions[0];
    businessModel = businessModelOptions[0];
    customerModel = customerModelOptions[0];
    stage = stageOptions[0];
    _loadSavedData();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      logoImage = pickedFile;
    });
  }

  Future<void> pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        slideshowFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _loadSavedData() async {
    projectDescriptionController.text =
        await SharedPrefHelper.getString('projectDescription') ?? '';
    aboutController.text = await SharedPrefHelper.getString('about') ?? '';
    sloganController.text = await SharedPrefHelper.getString('slogan') ?? '';
    typeController.text = await SharedPrefHelper.getString('type') ?? '';
    yearController.text = await SharedPrefHelper.getString('year') ?? '';
    amountController.text = await SharedPrefHelper.getString('amount') ?? '';
    serialNameController.text = await SharedPrefHelper.getString('serialName') ?? '';
    raisedWhereController.text = await SharedPrefHelper.getString('raisedWhere') ?? '';
  }

  Future<void> _saveDraft() async {
    await SharedPrefHelper.setData('projectDescription', projectDescriptionController.text);
    await SharedPrefHelper.setData('about', aboutController.text);
    await SharedPrefHelper.setData('slogan', sloganController.text);
    await SharedPrefHelper.setData('type', typeController.text);
    await SharedPrefHelper.setData('year', yearController.text);
    await SharedPrefHelper.setData('amount', amountController.text);
    await SharedPrefHelper.setData('serialName', serialNameController.text);
    await SharedPrefHelper.setData('raisedWhere', raisedWhereController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              verticalSpace(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: 45,
                      height: 45,
                      child: Image.asset("assets/images/logo_dark.png")),
                ],
              ),
              verticalSpace(20),
              Divider(
                color: AppColors.lightGray,
                thickness: 0.5,
              ),
              verticalSpace(20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: BuildFileUploadButton(
                        label: 'Slideshow',
                        file: slideshowFile,
                        onPressed: pickPDF),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: BuildImageUploadButton(
                        label: 'Logo',
                        image: logoImage,
                        onPressed: () => pickImage(ImageSource.gallery)),
                  ),
                ],
              ),
              verticalSpace(20),
              _buildTextField('Project Description', projectDescriptionController),
              _buildTextField('About', aboutController),
              _buildTextField('Slogan', sloganController),
              _buildDropdownField('Industry', industry, industryOptions, (String? newValue) {
                setState(() {
                  industry = newValue;
                });
              }),
              _buildDropdownField('Business Model', businessModel, businessModelOptions, (String? newValue) {
                setState(() {
                  businessModel = newValue;
                });
              }),
              _buildDropdownField('Customer Model', customerModel, customerModelOptions, (String? newValue) {
                setState(() {
                  customerModel = newValue;
                });
              }),
              _buildDropdownField('Stage', stage, stageOptions, (String? newValue) {
                setState(() {
                  stage = newValue;
                });
              }),
              _buildTextField('Founding Year', yearController),
              _buildTextField('Type', typeController),
              _buildTextField('Amount', amountController),
              _buildTextField('Legal Name', serialNameController),
              _buildTextField('Raised Funds', raisedWhereController),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: _saveDraft, child: Text('Save Draft')),
                  ElevatedButton(onPressed: () {}, child: Text('Upload')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      height: 80.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelStyle: AppTextStyles.font12PrimaryRegular.copyWith(color: AppColors.gray),
            fillColor: Colors.grey.shade100,
            filled: true,
            border: OutlineInputBorder(),
            labelText: label,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String?>(
            value: value,
            isDense: true,
            onChanged: onChanged,
            items: options.map<DropdownMenuItem<String?>>((String? value) {
              return DropdownMenuItem<String?>(
                value: value,
                child: Text(value!),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

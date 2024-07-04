import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:first_step/features/profile/data/models/profile_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.dart';
import '../../logic/profile_cubit.dart';

class ProfileDetailsForm extends StatefulWidget {
  final ProfileResponse profileResponse;

  const ProfileDetailsForm({
    required this.profileResponse,
  });

  @override
  State<ProfileDetailsForm> createState() => _ProfileDetailsFormState();
}

class _ProfileDetailsFormState extends State<ProfileDetailsForm> {

  @override
  void initState(){
    super.initState();
    context.read<ProfileCubit>().firstNameController = TextEditingController(text: widget.profileResponse.data?.firstName);
    context.read<ProfileCubit>().lastNameController = TextEditingController(text: widget.profileResponse.data?.lastName);
    context.read<ProfileCubit>().userNameController = TextEditingController(text: widget.profileResponse.data?.userName);
    context.read<ProfileCubit>().emailController = TextEditingController(text: widget.profileResponse.data?.email);
  }


  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(color: AppColors.white),
      child: SingleChildScrollView(

        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.edit, size: 15),
                    onPressed: () {
                      // Implement edit image logic
                    },
                  ),
                ),
              ),
            ),
            verticalSpace(10),
            TextButton(
              onPressed: () {
                // Todo Implement edit image logic
              },
              child: Text("Edit image",style: AppTextStyles.font16PrimaryLight,),
            ),
            verticalSpace(20),
            TextField(
              controller: context.read<ProfileCubit>().firstNameController,
              decoration: InputDecoration(
                labelText: "First Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            verticalSpace(20),
            TextField(
              controller: context.read<ProfileCubit>().lastNameController,
              decoration: InputDecoration(
                labelText:"Last Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            verticalSpace(20),
            TextField(
              controller: context.read<ProfileCubit>().userNameController,
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            verticalSpace(20),
            TextField(
              controller: context.read<ProfileCubit>().emailController,
              decoration: InputDecoration(
                labelText:"Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              readOnly: true,
            ),
            verticalSpace(60),

          ElevatedButton(
            onPressed: () {
              context.read<ProfileCubit>().updateProfile();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );

              //TODO :Replace the snackbar with states
            },
            child: Text("Save", style: AppTextStyles.font20WhiteBold.copyWith(fontSize: 12),),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

            verticalSpace(20),
            TextButton(
              onPressed: (){
                 context.pushNamed(Routes.changePasswordScreen);
              },
              child: Text("Change Password",style: AppTextStyles.font12PrimaryRegular,),
            ),
          ],
        ),
      ),
    );
  }
}

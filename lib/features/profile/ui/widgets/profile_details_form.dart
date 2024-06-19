import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
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


    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(
              'https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-07.jpg', // Replace with actual image URL
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
            child: Text("Edit image"),
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
          verticalSpace(30),

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
          child: Text("Save"),
          style: ElevatedButton.styleFrom(
            primary: AppColors.primaryColor,
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
            child: Text("Change Password"),
          ),
        ],
      ),
    );
  }
}

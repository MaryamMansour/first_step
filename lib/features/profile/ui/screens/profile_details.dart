import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile_cubit.dart';
import '../../logic/profile_state.dart';
import '../widgets/profile_details_form.dart';

class ProfileDetailsScreen extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ProfileDetailsConsumer(),
    );
  }
}

class ProfileDetailsConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
        current is profileError ||
        current is profileSuccess ||
        current is profileLoading,
      builder: (context, state) {
        return state.maybeWhen(
          profileLoading: () => Center(child: CircularProgressIndicator()),
          profileSuccess: (profileResponse) => ProfileDetailsForm(profileResponse: profileResponse),
          profileError: (errorHandler) => Center(child: Text("Error: $errorHandler")),
          orElse: () {
          return const SizedBox.shrink();

        },
        );
      },
    );
  }
}





// import 'package:first_step/core/helper/spacing.dart';
// import 'package:first_step/core/theming/colors.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
//
// class ProfileDetailsScreen extends StatefulWidget {
//   @override
//   _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
// }
//
// class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _firstNameController.text = "Tyler"; // Replace with actual data
//     _lastNameController.text = "Mason"; // Replace with actual data
//     _usernameController.text = "tyler.mason"; // Replace with actual data
//     _emailController.text = "tylermason309@gmail.com"; // Replace with actual data
//   }
//
//   void _updateProfile() {
//     // Implement profile update logic
//   }
//
//   void _navigateToChangePassword() {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => ChangePasswordScreen(),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit profile"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.grey[200],
//               backgroundImage: NetworkImage(
//                 'https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-07.jpg', // Replace with actual image URL
//               ),
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: CircleAvatar(
//                   radius: 15,
//                   backgroundColor: Colors.white,
//                   child: IconButton(
//                     icon: Icon(Icons.edit, size: 15),
//                     onPressed: () {
//                       // Implement edit image logic
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             verticalSpace(10),
//             TextButton(
//               onPressed: () {
//                 // Implement edit image logic
//               },
//               child: Text("Edit image"),
//             ),
//             verticalSpace(20),
//             TextField(
//               controller: _firstNameController,
//               decoration: InputDecoration(
//                 labelText: "First Name",
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             verticalSpace(20),
//             TextField(
//               controller: _lastNameController,
//               decoration: InputDecoration(
//                 labelText: "Last Name",
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             verticalSpace(20),
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 labelText: "Username",
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             verticalSpace(20),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: "Email",
//                 prefixIcon: Icon(Icons.email),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               readOnly: true,
//             ),
//             verticalSpace(30),
//             ElevatedButton(
//               onPressed: _updateProfile,
//               child: Text("Save"),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.black,
//                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             verticalSpace(20),
//             TextButton(
//               onPressed: _navigateToChangePassword,
//               child: Text("Change Password"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ChangePasswordScreen extends StatefulWidget {
//   @override
//   _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final TextEditingController _oldPasswordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//
//   void _changePassword() {
//     // Implement password change logic
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Change Password"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _oldPasswordController,
//               decoration: InputDecoration(
//                 labelText: "Enter old password",
//                 prefixIcon: Icon(Icons.lock),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               obscureText: true,
//             ),
//             verticalSpace(20),
//             TextField(
//               controller: _newPasswordController,
//               decoration: InputDecoration(
//                 labelText: "Enter new password",
//                 prefixIcon: Icon(Icons.lock),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               obscureText: true,
//             ),
//             verticalSpace(30),
//             ElevatedButton(
//               onPressed: _changePassword,
//               child: Text("Save"),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.black,
//                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

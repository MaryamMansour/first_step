import 'package:flutter/material.dart';
import 'package:first_step/features/profile/data/models/profile_response.dart'; // Import your profile response model

class ProfileDetailsForm extends StatelessWidget {
  final ProfileResponse profileResponse;

  const ProfileDetailsForm({
    required this.profileResponse,
  });

  void initState(){
    print("HIIIIII");
    print(profileResponse.data?.lastName);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _firstNameController = TextEditingController(text: profileResponse.data?.firstName);
    final TextEditingController _lastNameController = TextEditingController(text: profileResponse.data?.lastName);
    final TextEditingController _usernameController = TextEditingController(text: profileResponse.data?.userName);
    final TextEditingController _emailController = TextEditingController(text: profileResponse.data?.email);

    void _updateProfile() {
      // Implement profile update logic
    }

    void _navigateToChangePassword() {
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => ChangePasswordScreen(),
      // ));
    }

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
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Implement edit image logic
            },
            child: Text("Edit image"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _firstNameController,
            decoration: InputDecoration(
              labelText: "First Name",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText:"Last Name",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: "Username",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText:"Email",
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            readOnly: true,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: _updateProfile,
            child: Text("Save"),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: _navigateToChangePassword,
            child: Text("Change Password"),
          ),
        ],
      ),
    );
  }
}

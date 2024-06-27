import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/features/chat/ui/temp_chat.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _groupName = TextEditingController();
  final TextEditingController _groupDescription = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  void createGroup() async {
    if (_groupName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Group name cannot be empty")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    String groupId = _firestore.collection('groups').doc().id;
    String userId = await SharedPrefHelper.getString(SharedPrefKeys.id) ?? '';
    String userName = await SharedPrefHelper.getString(SharedPrefKeys.fName) ?? 'Unknown';
    String email = await SharedPrefHelper.getString(SharedPrefKeys.email) ?? 'Unknown';

    try {
      await _firestore.collection('groups').doc(groupId).set({
        "name": _groupName.text,
        "description": _groupDescription.text,
        "id": groupId,
        "members": [{"uid": userId, "name": userName, "email": email}],
        "memberUIDs":[userId],
        "createdAt": Timestamp.now(),
      });

      await _firestore.collection('groups').doc(groupId).collection('chats').add({
        "message": "$userName Created This Group.",
        "type": "notify",
        "timestamp": Timestamp.now(),
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => ChatScreen()), (route) => false);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred while creating group")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
      ),
      body: isLoading
          ? Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          SizedBox(height: size.height / 10),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _groupName,
                decoration: InputDecoration(
                  hintText: "Enter Group Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 50),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _groupDescription,
                decoration: InputDecoration(
                  hintText: "Enter Group Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 50),
          ElevatedButton(
            onPressed: createGroup,
            child: Text("Create Group"),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_step/core/networking/firestore_service.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:flutter/material.dart';

class AddMembersInGroup extends StatefulWidget {
  final String groupChatId, name;
  final List membersList;

  const AddMembersInGroup({
    required this.name,
    required this.membersList,
    required this.groupChatId,
    Key? key,
  }) : super(key: key);

  @override
  _AddMembersInGroupState createState() => _AddMembersInGroupState();
}

class _AddMembersInGroupState extends State<AddMembersInGroup> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late StreamController<String> _searchStreamController;
  List<Map<String, dynamic>> userList = [];
  bool isLoading = false;
  List membersList = [];

  @override
  void initState() {
    super.initState();
    membersList = widget.membersList;
    _searchStreamController = StreamController<String>.broadcast();
    _searchController.addListener(() {
      _searchStreamController.add(_searchController.text.toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchStreamController.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Add Members"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: size.height / 20),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search..",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 50),
          Expanded(
            child: UserList(
              collection: 'users',
              searchStream: _searchStreamController.stream,
            ),
          ),
        ],
      ),
    );
  }




  Widget buildUserItem(DocumentSnapshot document, {bool isMember = false}) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    String name = ("${data['fNAme']} ${data['lNAme']}") ??'Unknown';
    String email = data['email'] ?? 'No Email';
    String uid = document.id; // Get user id from document id

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              if (!isMember) {
                onAddMembers({"uid": uid, "name": name, "email": email});
              }
            },
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
              radius: 20,
            ),
            title: Text(name),
            subtitle: Text(email),
            trailing: isMember ? Icon(Icons.check) : Icon(Icons.add),
          ),
          const Divider(
            height: 2,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  Widget UserList({
    required String collection,
    required Stream<String> searchStream,
  }) {
    Stream<QuerySnapshot> stream = _firestore.collection(collection).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error fetching data: ${snapshot.error}"); // Logging error
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        print("Fetched documents: ${snapshot.data?.docs.length}"); // Logging number of documents fetched

        var docs = snapshot.data!.docs;

        print("Documents: ${docs.map((doc) => doc.data()).toList()}"); // Logging documents data

        return StreamBuilder<String>(
          stream: searchStream,
          initialData: '',
          builder: (context, searchSnapshot) {
            if (!searchSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            String searchQuery = searchSnapshot.data!.toLowerCase();
            var filteredDocs = docs.where((doc) {
              Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
              String name = (("${data['fNAme']} ${data['lNAme']}")?? '').toLowerCase();
              return name.contains(searchQuery);
            }).toList();

            return ListView(
              children: filteredDocs.map<Widget>((doc) {
                bool isMember = membersList.any((member) => member['uid'] == doc.id);
                return buildUserItem(doc, isMember: isMember);
              }).toList(),
            );
          },
        );
      },
    );
  }




  void onAddMembers(Map<String, dynamic> userMap) async {
    // If its already there
    if (userMap != null &&
        !membersList.any((member) => member['uid'] == userMap['uid'])) {
      membersList.add(userMap);

      // Update the members list in the Firestore group document

      FireStoreServices.updateGroupMembers(userMap, widget.groupChatId) ;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Member added successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Member already added or user not found")),
      );
    }
  }

}

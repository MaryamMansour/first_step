import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatelessWidget {
  final String groupChatId;
  final String groupName;
  final String description;

  const GroupDetailsScreen({
    required this.groupChatId,
    required this.groupName,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('groups')
                  .doc(groupChatId)
                  .collection('members')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                var members = snapshot.data!.docs;

                if (members.isEmpty) {
                  return Center(child: Text("No members found"));
                }

                return ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    var member = members[index].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                        radius: 20,
                      ),
                      title: Text(member['name'] ?? 'Unknown'),
                      subtitle: Text(member['email'] ?? 'No Email'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

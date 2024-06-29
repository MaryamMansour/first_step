import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
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
        backgroundColor: AppColors.primaryColor,
        title: Text(groupName),
      ),
      body: Column(
        children: [
          verticalSpace(15),
          Row(
            children: [
              horizontalSpace(30),
              Text(
                "Description",
                style: AppTextStyles.font16PrimaryLight,
              ),
            ],
          ),
          verticalSpace(6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Divider(
              height: 0.5,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          verticalSpace(15),
          Row(
            children: [
              horizontalSpace(30),
              Text(
                "Members",
                style: AppTextStyles.font16PrimaryLight,
              ),
            ],
          ),
          verticalSpace(6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Divider(
              height: 0.5,
              thickness: 1,
            ),
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream:
                  _firestore.collection('groups').doc(groupChatId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                var groupData = snapshot.data!.data() as Map<String, dynamic>;
                var members = groupData['members'] as List<dynamic>;

                if (members.isEmpty) {
                  return Center(child: Text("No members found"));
                }

                return ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    var member = members[index] as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                          radius: 20,
                        ),
                        title: Text(member['name'] ?? 'Unknown'),
                        subtitle: Text(member['email'] ?? 'No Email'),
                      ),
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

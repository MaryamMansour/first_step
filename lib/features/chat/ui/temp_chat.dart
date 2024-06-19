import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat_page.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 8, color: AppColors.gray)],
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(35),
                      bottomLeft: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          children: [
                            horizontalSpace(50),
                            Text("Chats", style: AppTextStyles.font24PrimaryBold),
                            horizontalSpace(MediaQuery.of(context).size.width - 140),
                            Container(
                              width: 50.w,
                                height: 50.h,
                                child: Image.asset('assets/images/logo_dark.png')),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20),
                        child: Container(
                          height: 45.h,
                          width: 300.w,
                          child: TextField(
                            controller: _searchController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.all(0.0),
                              fillColor: AppColors.lightGray,
                              hintText: 'Search...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.lightGray,
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              hintStyle: TextStyle(color: AppColors.white),
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TabBar(
                          indicatorColor: AppColors.primaryColor,
                          labelColor: AppColors.primaryColor,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: 'ALL'),
                            Tab(text: 'Groups'),
                            Tab(text: 'Channels'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    300, // Adjust height as needed
                child: TabBarView(
                  children: [
                    UserList(
                        collection: 'users',
                        searchController: _searchController),
                    UserList(
                        collection: 'groups',
                        searchController: _searchController),
                    UserList(
                        collection: 'channels',
                        searchController: _searchController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget UserList(
      {required String collection,
      required TextEditingController searchController}) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        String searchQuery = searchController.text.toLowerCase();
        var docs = snapshot.data!.docs.where((doc) {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
          String fullName = "${data['fNAme']} ${data['lNAme']}".toLowerCase();
          return fullName.contains(searchQuery);
        }).toList();

        return ListView(
          children: docs.map<Widget>((doc) => buildUserItem(doc)).toList(),
        );
      },
    );
  }

  Widget buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (SharedPrefHelper.getString(SharedPrefKeys.email) != data['email']) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                radius: 20,
              ),
              title: Text(
                "${data['fNAme'] + " " + data["lNAme"]}",
                style: AppTextStyles.font12PrimaryRegular.copyWith(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoomScreen(
                      receiverUserEmail: data['email'],
                      receiverUserID: data['id'].toString(),
                      receiverName:"${data['fNAme']} ${data['lNAme']}",
                    ),
                  ),
                );
              },
            ),
            const Divider(

              height: 2,
              thickness: 2,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

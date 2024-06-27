import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';

import 'add_members.dart';
import 'create_group.dart';
import 'chat_page.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _searchController = TextEditingController();
  late StreamController<String> _searchStreamController;
  String? userId;

  @override
  void initState() {
    super.initState();
    _searchStreamController = StreamController<String>.broadcast();
    _searchController.addListener(() {
      _searchStreamController.add(_searchController.text.toLowerCase());
    });
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await SharedPrefHelper.getString(SharedPrefKeys.id);
    print("Loaded User ID: $userId"); // Logging user ID
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Row(
                        children: [
                          horizontalSpace(40),
                          Text("Chats", style: AppTextStyles.font24PrimaryBold),
                          horizontalSpace(
                              MediaQuery.of(context).size.width - 200.w),
                          Container(
                            width: 50.w,
                            height: 50.h,
                            child: Image.asset('assets/images/logo_dark.png'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
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
                            hintStyle: const TextStyle(color: AppColors.white),
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
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
              Container(
                height: MediaQuery.of(context).size.height - 300,
                child: TabBarView(
                  children: [
                    UserList(
                      collection: 'users',
                      searchStream: _searchStreamController.stream,
                      userId: userId,
                    ),
                    GroupList(
                      userId: userId,
                    ),
                    UserList(
                      collection: 'channels',
                      searchStream: _searchStreamController.stream,
                      userId: userId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.group_add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateGroupScreen()),
            );
          },
        ),
      ),
    );
  }

  Widget UserList({
    required String collection,
    required Stream<String> searchStream,
    String? userId,
  }) {
    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }

    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(collection).snapshots();

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
              String name = (data['name'] ?? '').toLowerCase();
              return name.contains(searchQuery);
            }).toList();

            return ListView(
              children: filteredDocs.map<Widget>((doc) => buildUserItem(doc, collection)).toList(),
            );
          },
        );
      },
    );
  }

  Widget GroupList({
    String? userId,
  }) {
    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }

    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('groups').where('memberUIDs', arrayContains: userId).snapshots();

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

        return ListView(
          children: docs.map<Widget>((doc) => buildGroupItem(doc, userId)).toList(),
        );
      },
    );
  }

  Widget buildUserItem(DocumentSnapshot document, String collection) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    String? name;
    String? email;

    if (collection == 'users') {
      name = "${data['fNAme'] ?? ''} ${data['lNAme'] ?? ''}";
      email = data['email'];
    } else if (collection == 'channels') {
      name = data['name'];
      email = null;
    }

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
              name ?? 'Unknown',
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
                    description: "",
                    receiverUserEmails: email != null ? [email] : [],
                    receiverUserID: data['id'].toString(),
                    receiverName: name ?? 'Unknown',
                    isGroup: false,
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
  }

  Widget buildGroupItem(DocumentSnapshot document, String userId) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    String name = data['name'] ?? 'Unknown';
    String description = data['description'] ?? 'No description available';
    List<dynamic> members;

    print("HHHHHHHHHHHHHHHHHHHHH");
    print(data['members']);

    if (data['members'] is String) {
      members = [data['members']];
    } else if (data['members'] is List) {
      members = List<dynamic>.from(data['members']);
    } else {
      members = [];
    }

    if (!members.any((member) => member['uid'] == userId)) {
      return Container(); // Skip groups where the user is not a member
    }

    List<String> emails = [];
    if (data['email'] is String) {
      emails = [data['email']];
    } else if (data['email'] is List) {
      emails = List<String>.from(data['email']);
    }

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
              name,
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
                    description: description,
                    receiverUserEmails: members,
                    receiverUserID: data['id'].toString(),
                    receiverName: name,
                    isGroup: true,
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
  }
}

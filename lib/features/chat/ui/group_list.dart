// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:first_step/core/helper/shared_pref.dart';
// import 'package:first_step/core/theming/styles.dart';
// import 'package:first_step/core/theming/colors.dart';
// import '../../../core/networking/firestore_service.dart';
// import 'chat_page.dart';
//
// class GroupList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String?>(
//       future: SharedPrefHelper.getString('id'),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError || !snapshot.hasData) {
//           return Center(child: Text('Error fetching user ID'));
//         }
//         String userId = snapshot.data!;
//         return StreamBuilder<QuerySnapshot>(
//           stream: FireStoreServices.getGroupChats(userId),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Text("Error");
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             var docs = snapshot.data?.docs ?? [];
//             return ListView(
//               children: docs.map((doc) => buildGroupItem(context, doc)).toList(),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget buildGroupItem(BuildContext context, DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(
//                   "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
//               radius: 20,
//             ),
//             title: Text(
//               data['chatRoomTitle'],
//               style: AppTextStyles.font12PrimaryRegular.copyWith(
//                 fontSize: 18,
//                 color: Colors.black,
//               ),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ChatRoomScreen(
//                     receiverUserEmail: "", // Empty as it's a group chat
//                     receiverUserID: data['id'].toString(),
//                     receiverName: data['chatRoomTitle'],
//                   ),
//                 ),
//               );
//             },
//           ),
//           const Divider(
//             height: 2,
//             thickness: 2,
//           ),
//         ],
//       ),
//     );
//   }
// }

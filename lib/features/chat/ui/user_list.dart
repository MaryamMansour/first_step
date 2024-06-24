// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:first_step/core/helper/shared_pref.dart';
// import 'package:first_step/core/theming/styles.dart';
// import 'package:first_step/core/theming/colors.dart';
//
// import '../../../core/helper/constants.dart';
// import 'chat_page.dart';
//
// class UserList extends StatelessWidget {
//   final String collection;
//   final Stream<String> searchStream;
//   final void Function(DocumentSnapshot)? onUserSelected;
//   final List<DocumentSnapshot>? selectedUsers;
//
//   UserList({
//     required this.collection,
//     required this.searchStream,
//     this.onUserSelected,
//     this.selectedUsers,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection(collection).snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text("Error");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         return StreamBuilder<String>(
//           stream: searchStream,
//           initialData: '',
//           builder: (context, searchSnapshot) {
//             if (!searchSnapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             String searchQuery = searchSnapshot.data!.toLowerCase();
//             var docs = snapshot.data!.docs.where((doc) {
//               Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
//               String firstName = (data['fNAme'] ?? '').toLowerCase();
//               String lastName = (data['lNAme'] ?? '').toLowerCase();
//               String fullName = "$firstName $lastName";
//               return fullName.contains(searchQuery);
//             }).toList();
//
//             return ListView(
//               children: docs.map<Widget>((doc) => buildUserItem(context, doc)).toList(),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget buildUserItem(BuildContext context, DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//     bool isSelected = selectedUsers?.contains(document) ?? false;
//
//     if (SharedPrefHelper.getString(SharedPrefKeys.email) != data['email']) {
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(
//                     "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
//                 radius: 20,
//                 child: isSelected ? Icon(Icons.check, color: AppColors.primaryColor) : null,
//               ),
//               title: Text(
//                 "${data['fNAme'] + " " + data["lNAme"]}",
//                 style: AppTextStyles.font12PrimaryRegular.copyWith(
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//               ),
//               onTap: onUserSelected != null ? () => onUserSelected!(document) : () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChatRoomScreen(
//                       receiverUserEmail: data['email'],
//                       receiverUserID: data['id'].toString(),
//                       receiverName: "${data['fNAme']} ${data['lNAme']}",
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const Divider(
//               height: 2,
//               thickness: 2,
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }

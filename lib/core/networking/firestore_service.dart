import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/features/chat/data/model/message_model.dart';

class FireStoreServices {

  static Future<void> addUser(String userId, String username, String email,
      String firstName, String lastName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(userId).set({
      'username': username,
      'email': email,
      'fNAme': firstName,
      'lNAme': lastName,
      'id':userId,
    }, SetOptions(merge: true));
  }
  static Future<void> updateUser(String userId, String username, String email,
      String firstName, String lastName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(userId).update({
      'username': username,
      'email': email,
      'fNAme': firstName,
      'lNAme': lastName,
    });
  }


  static Future<void> sendMessage(String receiverId, String message) async {
    try {
      final String currentUserId = await SharedPrefHelper.getString(SharedPrefKeys.id);
      final String currentUserEmail = await SharedPrefHelper.getString(SharedPrefKeys.email);
      final String currentUserName = await SharedPrefHelper.getString(SharedPrefKeys.fName);
      final Timestamp timestamp = Timestamp.now();

      print("Current User ID: $currentUserId");
      print("Current User Email: $currentUserEmail");

      if (currentUserId == null || currentUserEmail == null) {
        print("Failed to get current user info from SharedPref");
        return;
      }

      Message newMessage = Message(
        senderName: currentUserName,
        senderId: currentUserId,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        timestamp: timestamp,
        message: message,
      );

      print("Current User Name ${currentUserName}");
      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");

      CollectionReference chats = FirebaseFirestore.instance.collection('chat_rooms');
      await chats.doc(chatRoomId).collection('messages').add(newMessage.toMap());

      print("Message sent successfully");
    } catch (e) {
      print("Failed to send message: $e");
    }
  }




  static Stream<QuerySnapshot> getMessages(String userId, String otherUsrId){
    List<String> ids = [userId, otherUsrId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();

  }
}

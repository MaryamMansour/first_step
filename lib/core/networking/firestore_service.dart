import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/features/chat/data/model/message_model.dart';

class FireStoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addUser(String userId, String username, String email,
      String firstName, String lastName) async {
    CollectionReference users = _firestore.collection('users');
    await users.doc(userId).set({
      'username': username,
      'email': email,
      'fNAme': firstName,
      'lNAme': lastName,
      'id': userId,
    }, SetOptions(merge: true));
  }

  static Future<void> updateUser(String userId, String username, String email,
      String firstName, String lastName) async {
    CollectionReference users = _firestore.collection('users');
    await users.doc(userId).update({
      'username': username,
      'email': email,
      'fNAme': firstName,
      'lNAme': lastName,
    });
  }

  static Future<void> sendMessage(String receiverId, String message) async {
    try {
      final String? currentUserId =
      await SharedPrefHelper.getString(SharedPrefKeys.id);
      final String? currentUserEmail =
      await SharedPrefHelper.getString(SharedPrefKeys.email);
      final String? currentUserName =
      await SharedPrefHelper.getString(SharedPrefKeys.fName);
      final Timestamp timestamp = Timestamp.now();

      if (currentUserId == null || currentUserEmail == null) {
        print("Current user ID or email is null");
        return;
      }

      Message newMessage = Message(
        senderName: currentUserName!,
        senderId: currentUserId,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        timestamp: timestamp,
        message: message,
      );

      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");

      CollectionReference chats =
      FirebaseFirestore.instance.collection('chat_rooms');
      await chats
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());

      print("Message sent to chat room $chatRoomId");
    } catch (e) {
      print("Failed to send message: $e");
    }
  }

  static Future<void> sendGroupMessage(String groupId, String message) async {
    try {
      final String? currentUserId =
      await SharedPrefHelper.getString(SharedPrefKeys.id);
      final String? currentUserName =
      await SharedPrefHelper.getString(SharedPrefKeys.fName);
      final Timestamp timestamp = Timestamp.now();

      if (currentUserId == null) {
        print("Current user ID is null");
        return;
      }

      Message newMessage = Message(
        senderName: currentUserName!,
        senderId: currentUserId,
        receiverId: groupId,
        timestamp: timestamp,
        message: message,
        senderEmail: currentUserName,
      );

      CollectionReference groupChats =
      FirebaseFirestore.instance.collection('groups');
      await groupChats
          .doc(groupId)
          .collection('messages')
          .add(newMessage.toMap());

      print("Message sent to group $groupId");
    } catch (e) {
      print("Failed to send group message: $e");
    }
  }

  static Future<void> sendChannelMessage(String channelId, String message) async {
    try {
      final String? currentUserId =
      await SharedPrefHelper.getString(SharedPrefKeys.id);
      final String? currentUserName =
      await SharedPrefHelper.getString(SharedPrefKeys.fName);
      final Timestamp timestamp = Timestamp.now();

      if (currentUserId == null) {
        print("Current user ID is null");
        return;
      }

      Message newMessage = Message(
        senderName: currentUserName!,
        senderId: currentUserId,
        receiverId: channelId,
        timestamp: timestamp,
        message: message,
        senderEmail: currentUserName,
      );

      CollectionReference channelChats =
      FirebaseFirestore.instance.collection('channels');
      await channelChats
          .doc(channelId)
          .collection('messages')
          .add(newMessage.toMap());

      print("Message sent to channel $channelId");
    } catch (e) {
      print("Failed to send channel message: $e");
    }
  }

  static Future<void> createGroup(
      String userId, String name, String description) async {
    CollectionReference groups = _firestore.collection('groups');
    await groups.add({
      'name': name,
      'description': description,
      'creator': userId,
      'members': [userId],
      'createdAt': Timestamp.now(),
    });
  }

  static Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> getGroupMessages(String groupId) {
    return _firestore
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> getChannelMessages(String channelId) {
    return _firestore
        .collection("channels")
        .doc(channelId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  static Future<void> updateGroupMembers(Map<String, dynamic> userMap, String groupChatId) async {
    await _firestore.collection('groups').doc(groupChatId).update({
      "members": FieldValue.arrayUnion([userMap]),
      'memberUIDs': FieldValue.arrayUnion([userMap['uid']])
    });
  }
}

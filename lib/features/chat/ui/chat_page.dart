import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/features/chat/ui/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/networking/firestore_service.dart';
import '../../../core/widgets/text_form_field.dart';
import 'add_members.dart';
import 'grou_details.dart';

class ChatRoomScreen extends StatefulWidget {
  final List<String> receiverUserEmails;
  final String receiverUserID;
  final String receiverName;
  final bool isGroup;
  final String description;

  const ChatRoomScreen({
    super.key,
    required this.receiverUserEmails,
    required this.receiverUserID,
    required this.receiverName,
    this.isGroup = false,
    required this.description,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messagesController = TextEditingController();
  String? userId;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await SharedPrefHelper.getString(SharedPrefKeys.id);
    userName = await SharedPrefHelper.getString(SharedPrefKeys.fName);
    setState(() {});
  }

  void sendMessage() async {
    if (_messagesController.text.isNotEmpty && userId != null) {
      if (widget.isGroup) {
        await FireStoreServices.sendGroupMessage(
            widget.receiverUserID, _messagesController.text);
      } else {
        await FireStoreServices.sendMessage(
            widget.receiverUserID, _messagesController.text);
      }
      _messagesController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: GestureDetector(
          onTap: () {
            if (widget.isGroup) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupDetailsScreen(
                    groupChatId: widget.receiverUserID,
                    groupName: widget.receiverName,
                    description: widget.description,
                  ),
                ),
              );
            }
          },
          child: Text(widget.receiverName),
        ),
        actions: [
          if (widget.isGroup)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMembersInGroup(
                      name: widget.receiverName,
                      groupChatId: widget.receiverUserID,
                      membersList: [], // Pass the actual members list
                    ),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
                height: 25,
                width: 25,
                child: Image.asset('assets/images/logo_light.png')),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: userId != null
                ? buildMessageList()
                : Center(child: CircularProgressIndicator()),
          ),
          buildMessageInput(),
          verticalSpace(20),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: widget.isGroup
          ? FireStoreServices.getGroupMessages(widget.receiverUserID)
          : FireStoreServices.getMessages(widget.receiverUserID, userId!),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const Text("Loading.."));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet."));
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => MessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget MessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    Color color = (data['senderId'] == userId)
        ? AppColors.primaryColor
        : AppColors.lightGray;
    var alignment = (data['senderId'] == userId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    Timestamp timestamp = data['timestamp'];

    String time = DateFormat.Hm().format(timestamp.toDate());
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == userId)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == userId)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(data['senderName']),
            verticalSpace(5),
            ChatBubble(message: data['message'], color: color),
            verticalSpace(5),
            Text(
              time, // Display formatted time
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: AppTextFormField(
                width: 20,
                hintText: "Enter Message",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                },
                controller: _messagesController,
              )),
          Container(
            decoration: const BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                )),
            child: IconButton(
              icon: Icon(Icons.send, color: AppColors.white),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

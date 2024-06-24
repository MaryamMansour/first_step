class ChatRoom {
  final String id;
  final String chatRoomTitle;
  final List<String> memberIds;
  final List<Map<String, dynamic>> members;
  final bool isGroup;

  ChatRoom({
    required this.id,
    required this.chatRoomTitle,
    required this.memberIds,
    required this.members,
    required this.isGroup,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatRoomTitle': chatRoomTitle,
      'memberIds': memberIds,
      'members': members,
      'isGroup': isGroup,
    };
  }

  static ChatRoom fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      chatRoomTitle: map['chatRoomTitle'],
      memberIds: List<String>.from(map['memberIds']),
      members: List<Map<String, dynamic>>.from(map['members']),
      isGroup: map['isGroup'],
    );
  }
}

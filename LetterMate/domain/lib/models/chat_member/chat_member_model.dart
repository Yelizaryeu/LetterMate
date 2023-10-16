class ChatMemberModel {
  final String uid;
  final String uuid;
  final String name;
  final String fCMToken;
  String isTyping;

  ChatMemberModel({required this.uid, required this.uuid, required this.name, required this.fCMToken, required this.isTyping});
}
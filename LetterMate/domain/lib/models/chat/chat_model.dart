import 'package:domain/models/chat_member/chat_member_model.dart';

class ChatModel {
  final String chatId;
  final String chatIcon;
  final List<dynamic> members;
  String? recentMessage;
  int? recentMessageTime;
  String? recentMessageSender;

  ChatModel({
    required this.chatId, required this.chatIcon, required this.members ,this.recentMessageSender, this.recentMessageTime, this.recentMessage,
  });
}
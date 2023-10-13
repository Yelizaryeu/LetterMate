import 'package:domain/models/chat/chat_model.dart';


class ChatEntity extends ChatModel {

  ChatEntity(
      {required super.chatId, required super.chatIcon, required super.members, super.recentMessage, super.recentMessageTime, super.recentMessageSender,
      });


  factory ChatEntity.fromJson(Map<String, dynamic> json) {
    return ChatEntity(
      chatId: json['chatId'],
      chatIcon: json['chatIcon'],
      members: json['members'],
      recentMessage: json['recentMessage'],
      recentMessageTime: json['recentMessageTime'],
      recentMessageSender: json['recentMessageSender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'chatIcon': chatIcon,
      'members': members,
      'recentMessage': recentMessage,
      'recentMessageTime': recentMessageTime,
      'recentMessageSender': recentMessageSender,
    };
  }

  @override
  String toString() {
    return 'chatId: $chatId';
  }
}
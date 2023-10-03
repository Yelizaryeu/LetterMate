import 'package:domain/models/chat/chat_model.dart';


class ChatEntity extends ChatModel {

  ChatEntity(
      {required super.chatName, required super.chatId, required super.chatIcon, super.resentMessage, super.resentMessageSender,
      });


  factory ChatEntity.fromJson(Map<String, dynamic> json) {
    return ChatEntity(
      chatName: json['chatName'],
      chatId: json['chatId'],
      chatIcon: json['chatIcon'],
      resentMessage: json['resentMessage'],
      resentMessageSender: json['resentMessageSender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatName' : chatName,
      'chatId': chatId,
      'chatIcon': chatIcon,
      'resentMessage' : resentMessage,
      'resentMessageSender' : resentMessageSender,
    };
  }

  @override
  String toString() {
    return 'chatName: $chatName';
  }
}
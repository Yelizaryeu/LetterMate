import 'package:domain/models/chat_member/chat_member_model.dart';

class ChatMemberEntity extends ChatMemberModel {

  ChatMemberEntity(
      { required super.uid,
        required super.uuid,
        required super.name,
        required super.fCMToken,
        required super.isTyping,
      });


  factory  ChatMemberEntity.fromJson(Map<String, dynamic> json) {

    return ChatMemberEntity(
      uid: json['uid'],
      uuid: json["uuid"],
      name: json['name'],
      fCMToken: json['fCMToken'],
      isTyping: json['isTyping'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid' : uid,
      'uuid' : uuid,
      'name': name,
      'fCMToken': fCMToken,
      'isTyping' : isTyping,
    };
  }

  @override
  String toString() {
    return 'UUID: $uuid, Name: $name';
  }
}
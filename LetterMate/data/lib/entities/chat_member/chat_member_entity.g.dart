// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMemberEntityImpl _$$ChatMemberEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMemberEntityImpl(
      uuid: json['uuid'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String,
      chatId: json['chatId'] as String,
      photoURL: json['photoURL'] as String,
      fCMToken: json['fCMToken'] as String,
      isTyping: json['isTyping'] as String,
    );

Map<String, dynamic> _$$ChatMemberEntityImplToJson(
        _$ChatMemberEntityImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'uid': instance.uid,
      'name': instance.name,
      'chatId': instance.chatId,
      'photoURL': instance.photoURL,
      'fCMToken': instance.fCMToken,
      'isTyping': instance.isTyping,
    };

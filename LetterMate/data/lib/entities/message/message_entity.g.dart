// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageEntityImpl _$$MessageEntityImplFromJson(Map<String, dynamic> json) =>
    _$MessageEntityImpl(
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      message: json['message'] as String,
      chatId: json['chatId'] as String,
      time: json['time'] as int,
      messageType: json['messageType'] as String,
      isEdited: json['isEdited'] as bool,
      isDeleted: json['isDeleted'] as bool,
    );

Map<String, dynamic> _$$MessageEntityImplToJson(_$MessageEntityImpl instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'message': instance.message,
      'chatId': instance.chatId,
      'time': instance.time,
      'messageType': instance.messageType,
      'isEdited': instance.isEdited,
      'isDeleted': instance.isDeleted,
    };

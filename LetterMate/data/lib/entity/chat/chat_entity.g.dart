// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatEntityImpl _$$ChatEntityImplFromJson(Map<String, dynamic> json) =>
    _$ChatEntityImpl(
      chatId: json['chatId'] as String,
      members: json['members'] as List<dynamic>,
      recentMessage: json['recentMessage'] as String,
      recentMessageTime: json['recentMessageTime'] as int?,
      recentMessageSender: json['recentMessageSender'] as String?,
    );

Map<String, dynamic> _$$ChatEntityImplToJson(_$ChatEntityImpl instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'members': instance.members,
      'recentMessage': instance.recentMessage,
      'recentMessageTime': instance.recentMessageTime,
      'recentMessageSender': instance.recentMessageSender,
    };

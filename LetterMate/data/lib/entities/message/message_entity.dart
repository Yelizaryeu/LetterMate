import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';

@freezed
class MessageEntity with _$MessageEntity {
  factory MessageEntity({
    required String senderId,
    required String senderName,
    required String message,
    required String chatId,
    required int time,
    required String messageType,
    required bool isEdited,
    required bool isDeleted,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);
}

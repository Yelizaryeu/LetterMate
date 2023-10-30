import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    required String senderId,
    required String senderName,
    required String message,
    required String chatId,
    required int time,
    required String messageType,
    required bool isEdited,
    required bool isDeleted,
  }) = _MessageModel;
}

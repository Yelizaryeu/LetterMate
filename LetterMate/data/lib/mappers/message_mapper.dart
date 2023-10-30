import 'package:domain/models/message/message_model.dart';

import '../entities/message/message_entity.dart';

abstract class MessageMapper {
  static MessageEntity toEntity(MessageModel model) {
    return MessageEntity(
      senderId: model.senderId,
      senderName: model.senderName,
      message: model.message,
      chatId: model.chatId,
      time: model.time,
      messageType: model.messageType,
      isEdited: model.isEdited,
      isDeleted: model.isDeleted,
    );
  }

  static MessageModel toModel(MessageEntity entity) {
    return MessageModel(
      senderId: entity.senderId,
      senderName: entity.senderName,
      message: entity.message,
      chatId: entity.chatId,
      time: entity.time,
      messageType: entity.messageType,
      isEdited: entity.isEdited,
      isDeleted: entity.isDeleted,
    );
  }
}

import 'package:domain/models/chat_member/chat_member_model.dart';

import '../entities/chat_member/chat_member_entity.dart';

abstract class ChatMemberMapper {
  static ChatMemberEntity toEntity(ChatMemberModel model) {
    return ChatMemberEntity(
      uuid: model.uuid,
      uid: model.uid,
      name: model.name,
      chatId: model.chatId,
      photoURL: model.photoURL,
      fCMToken: model.fCMToken,
      isTyping: model.isTyping,
    );
  }

  static ChatMemberModel toModel(ChatMemberEntity entity) {
    return ChatMemberModel(
      uuid: entity.uuid,
      uid: entity.uid,
      name: entity.name,
      chatId: entity.chatId,
      photoURL: entity.photoURL,
      fCMToken: entity.fCMToken,
      isTyping: entity.isTyping,
    );
  }
}

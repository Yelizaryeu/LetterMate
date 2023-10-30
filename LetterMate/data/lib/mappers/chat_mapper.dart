import 'package:data/data.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart';

abstract class ChatMapper {
  static ChatEntity toEntity(ChatModel model) {
    List<ChatMemberEntity> membersEntityList = [];
    for (ChatMemberModel memberModel in model.members) {
      membersEntityList.add(ChatMemberMapper.toEntity(memberModel));
    }
    return ChatEntity(
      members: membersEntityList,
      chatId: model.chatId,
      recentMessage: model.recentMessage,
      recentMessageTime: model.recentMessageTime,
      recentMessageSender: model.recentMessageSender,
    );
  }

  static ChatModel toModel(ChatEntity entity) {
    List<ChatMemberModel> membersModelList = [];
    for (ChatMemberEntity memberEntity in entity.members) {
      membersModelList.add(ChatMemberMapper.toModel(memberEntity));
    }
    return ChatModel(
      members: membersModelList,
      chatId: entity.chatId,
      recentMessage: entity.recentMessage,
      recentMessageTime: entity.recentMessageTime,
      recentMessageSender: entity.recentMessageSender,
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../chat_member/chat_member_entity.dart';

part 'chat_entity.freezed.dart';
part 'chat_entity.g.dart';

@freezed
class ChatEntity with _$ChatEntity {
  factory ChatEntity({
    required String chatId,
    required List<ChatMemberEntity> members,
    required String recentMessage,
    required int? recentMessageTime,
    required String? recentMessageSender,
  }) = _ChatEntity;

  factory ChatEntity.fromJson(Map<String, dynamic> json) => _$ChatEntityFromJson(json);
}

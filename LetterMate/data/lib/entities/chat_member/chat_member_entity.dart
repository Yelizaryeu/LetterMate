import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_member_entity.freezed.dart';
part 'chat_member_entity.g.dart';

@freezed
class ChatMemberEntity with _$ChatMemberEntity {
  factory ChatMemberEntity({
    required String uuid,
    required String uid,
    required String name,
    required String chatId,
    required String photoURL,
    required String fCMToken,
    required String isTyping,
  }) = _ChatMemberEntity;

  factory ChatMemberEntity.fromJson(Map<String, dynamic> json) => _$ChatMemberEntityFromJson(json);
}

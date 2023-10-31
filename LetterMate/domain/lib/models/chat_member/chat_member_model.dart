import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_member_model.freezed.dart';

@freezed
class ChatMemberModel with _$ChatMemberModel {
  factory ChatMemberModel({
    required String uuid,
    required String uid,
    required String name,
    required String photoURL,
    required String fCMToken,
    required String isTyping,
  }) = _ChatMemberModel;
}

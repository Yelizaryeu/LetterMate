import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_entity.freezed.dart';
part 'chat_entity.g.dart';

@freezed
class ChatEntity with _$ChatEntity {
  factory ChatEntity({
    required String chatId,
    required List<dynamic> members,
    required String recentMessage,
    required int? recentMessageTime,
    required String? recentMessageSender,
  }) = _ChatEntity;

  factory ChatEntity.fromJson(Map<String, dynamic> json) => _$ChatEntityFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';

@freezed
class ChatModel with _$ChatModel {
  factory ChatModel({
    required String chatId,
    required List<dynamic> members,
    required String recentMessage,
    required int? recentMessageTime,
    required String? recentMessageSender,
  }) = _ChatModel;
}

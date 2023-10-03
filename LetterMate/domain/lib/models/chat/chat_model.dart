class ChatModel {
  final String chatName;
  final String chatId;
  final String chatIcon;
  String? resentMessage;
  String? resentMessageSender;

  ChatModel({
    required this.chatName, required this.chatId, required this.chatIcon, this.resentMessageSender, this.resentMessage,
  });
}
part of 'bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class ChatInitEvent extends ChatEvent {
  final String chatId;

  const ChatInitEvent(this.chatId);
}

class NewChatEvent extends ChatEvent {
  final List<MessageModel>? messages;

  const NewChatEvent(this.messages);
}

class NewMembersEvent extends ChatEvent {
  final List<ChatMemberModel>? members;

  const NewMembersEvent(this.members);
}

class DeleteMessageEvent extends ChatEvent {
  final MessageModel message;

  const DeleteMessageEvent(this.message);
}

class DeleteChatEvent extends ChatEvent {
  final String chatId;

  const DeleteChatEvent(this.chatId);
}

class EditModeEvent extends ChatEvent {
  final String editId;

  const EditModeEvent(this.editId);
}

class EditMessageEvent extends ChatEvent {
  final MessageModel message;

  const EditMessageEvent(this.message);
}

class FileSelectEvent extends ChatEvent {}

class TypingMessageEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final MessageModel message;

  const SendMessageEvent(this.message);
}

part of 'bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatFetchedEvent extends ChatEvent {
  final String chatId;
  const ChatFetchedEvent(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final Map<String, dynamic> chatMessageData;
  const SendMessageEvent(this.chatId, this.chatMessageData);

  @override
  List<Object?> get props => [chatId, chatMessageData];
}

class ChatUpdateEvent extends ChatEvent {
  final ChatEntity chatEntity;
  const ChatUpdateEvent(this.chatEntity);

  @override
  List<Object?> get props => [chatEntity];
}
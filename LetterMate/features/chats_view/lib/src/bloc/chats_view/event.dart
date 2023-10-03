part of 'bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object?> get props => [];
}

class ChatsFetchedEvent extends ChatsEvent {
  //final List<String> chats;
  const ChatsFetchedEvent();
  @override
  List<Object?> get props => [];
}
part of 'bloc.dart';

abstract class ChatsEvent {
  const ChatsEvent();
}

class NewChatsEvent extends ChatsEvent {
  final UserModel userModel;

  NewChatsEvent(this.userModel);
}

class ChatsCreateEvent extends ChatsEvent {
  final String companionId;
  const ChatsCreateEvent(this.companionId);
}

class ChatsErrorEvent extends ChatsEvent {}

class ChatsDeleteEvent extends ChatsEvent {}

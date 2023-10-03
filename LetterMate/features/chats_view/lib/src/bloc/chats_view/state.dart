part of 'bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object?> get props => [];
}

class ChatsEmptyState extends ChatsState {}

class ChatsLoadedState extends ChatsState {
  final Stream<DocumentSnapshot> chats;
  const ChatsLoadedState(this.chats);

  @override
  List<Object?> get props => [chats];
}

class ChatsErrorState extends ChatsState {
  final String message;

  ChatsErrorState({required this.message});
}


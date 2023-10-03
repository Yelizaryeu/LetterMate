part of 'bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatEmptyState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  //final UserEntity userData;
  final ChatEntity chatEntity;
  const ChatLoadedState(this.chatEntity);


}

class ChatErrorState extends ChatState {
  final String message;

  const ChatErrorState({required this.message});
}


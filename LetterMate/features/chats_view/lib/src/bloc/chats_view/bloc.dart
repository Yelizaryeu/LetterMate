import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final UpdateUserDataUseCase _updateUserDataUseCase;
  final GettingUserDataUseCase _gettingUserDataUseCase;
  final CreateChatUseCase _createChatUseCase;
  final CheckUserExistenceUseCase _checkUserExistenceUseCase;
  Stream<UserModel>? _userData;

  ChatsBloc({
    required UpdateUserDataUseCase updateUserDataUseCase,
    required GettingUserDataUseCase gettingUserDataUseCase,
    required CreateChatUseCase createChatUseCase,
    required CheckUserExistenceUseCase checkUserExistenceUseCase,
  })  : _updateUserDataUseCase = updateUserDataUseCase,
        _gettingUserDataUseCase = gettingUserDataUseCase,
        _createChatUseCase = createChatUseCase,
        _checkUserExistenceUseCase = checkUserExistenceUseCase,
        super(const ChatsState()) {
    _initChats();
    on<NewChatsEvent>(_onNewChatsEvent);
    on<ChatsCreateEvent>(_onChatsCreateEvent);
  }

  void _initChats() {
    print('initing chats');
    _userData ??= _gettingUserDataUseCase.execute(const NoParams());
    print('chats inited');

    _userData?.listen(_chatListener);
  }

  void _chatListener(UserModel event) {
    add(NewChatsEvent(event));
  }

  Future<void> _onNewChatsEvent(
    NewChatsEvent event,
    Emitter<ChatsState> emit,
  ) async {
    print('new chats event');
    emit(
      state.copyWith(
        userModel: event.userModel,
        isLoading: false,
      ),
    );
  }

  Future<void> _onChatsCreateEvent(
    ChatsCreateEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    await _checkUserExistenceUseCase.execute(event.companionId)
        ? _createChatUseCase.execute(event.companionId)
        : add(ChatsErrorEvent());
  }

  Future<void> _onChatsErrorEvent(
    ChatsCreateEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(state.copyWith(
      error: true,
    ));
  }
}

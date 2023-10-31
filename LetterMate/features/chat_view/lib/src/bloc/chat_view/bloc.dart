import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'event.dart';
part 'state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GettingChatMessagesUseCase _gettingChatMessagesUseCase;
  final GettingChatMembersUseCase _gettingChatMembersUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final SendFileUseCase _sendFileUseCase;
  final DeleteMessageUseCase _deleteMessageUseCase;
  final DeleteChatUseCase _deleteChatUseCase;
  final EditMessageUseCase _editMessageUseCase;
  final TypingMessageUseCase _typingMessageUseCase;
  final String _chatId;
  Stream<List<MessageModel>?>? _messages;
  Stream<List<ChatMemberModel>?>? _members;

  ChatBloc({
    required GettingChatMessagesUseCase gettingChatMessagesUseCase,
    required GettingChatMembersUseCase gettingChatMembersUseCase,
    required GetUserDataUseCase getUserDataUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required SendFileUseCase sendFileUseCase,
    required DeleteMessageUseCase deleteMessageUseCase,
    required DeleteChatUseCase deleteChatUseCase,
    required EditMessageUseCase editMessageUseCase,
    required TypingMessageUseCase typingMessageUseCase,
    required String chatId,
  })  : _gettingChatMessagesUseCase = gettingChatMessagesUseCase,
        _gettingChatMembersUseCase = gettingChatMembersUseCase,
        _getUserDataUseCase = getUserDataUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _sendFileUseCase = sendFileUseCase,
        _deleteMessageUseCase = deleteMessageUseCase,
        _deleteChatUseCase = deleteChatUseCase,
        _editMessageUseCase = editMessageUseCase,
        _typingMessageUseCase = typingMessageUseCase,
        _chatId = chatId,
        super(const ChatState()) {
    //on<ChatInitEvent>(_onChatInitEvent);
    on<NewChatEvent>(_onNewChatEvent);
    on<NewMembersEvent>(_onNewMembersEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<DeleteMessageEvent>(_onDeleteMessageEvent);
    on<DeleteChatEvent>(_onDeleteChatEvent);
    on<FileSelectEvent>(_onFileSelectEvent);
    on<EditModeEvent>(_onEditModeEvent);
    on<EditMessageEvent>(_onEditMessageEvent);
    on<TypingMessageEvent>(_onTypingMessageEvent);
    _initChat();
  }

  void _initChat() {
    print('getting messages');
    _messages ??= _gettingChatMessagesUseCase.execute(_chatId);
    _members ??= _gettingChatMembersUseCase.execute(_chatId);

    print('got messages');

    _messages?.listen((List<MessageModel>? event) {
      print('add NewChatEvent');
      add(NewChatEvent(event));
    });
    _members?.listen((List<ChatMemberModel>? event) {
      add(NewMembersEvent(event));
    });
  }

  Future<void> _onNewChatEvent(
    NewChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    UserModel? user;
    if (state.userName == '') {
      user = await _getUserDataUseCase.execute(const NoParams());
    }
    emit(
      state.copyWith(
        messages: event.messages,
        chatId: _chatId,
        userName: user?.displayName,
        isLoading: false,
      ),
    );
  }

  Future<void> _onNewMembersEvent(
    NewMembersEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(
      members: event.members,
    ));
  }

  Future<void> _onSendMessageEvent(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    _sendMessageUseCase.execute(event.message);
    emit(
      state.copyWith(
        messages: state.messages,
        isTyping: false,
      ),
    );
    if (state.members![0].name == state.userName) {
      _typingMessageUseCase.execute(
        state.members![0].copyWith(
          isTyping: 'false',
        ),
      );
    } else {
      _typingMessageUseCase.execute(
        state.members![1].copyWith(
          isTyping: 'false',
        ),
      );
    }
  }

  Future<void> _onFileSelectEvent(
    FileSelectEvent event,
    Emitter<ChatState> emit,
  ) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    print('executing sendMessageUseCase');
    _sendFileUseCase.execute(MessageModel(
        senderId: '',
        senderName: state.userName,
        message: result.files.first.path!,
        chatId: state.chatId,
        time: DateTime.now().millisecondsSinceEpoch,
        messageType: 'image',
        isEdited: false,
        isDeleted: false));
  }

  Future<void> _onEditModeEvent(
    EditModeEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(
      editId: event.editId,
      isEditMode: true,
    ));
  }

  Future<void> _onEditMessageEvent(
    EditMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    _editMessageUseCase.execute(event.message);
    emit(state.copyWith(
      isEditMode: false,
    ));
  }

  Future<void> _onTypingMessageEvent(
    TypingMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    print('emitting isTyping: true');
    emit(state.copyWith(
      isTyping: true,
    ));
    if (state.isTyping == true) {
      if (state.members![0].name == state.userName) {
        print('setting member[0] is typing');
        _typingMessageUseCase.execute(
          state.members![0].copyWith(
            isTyping: 'true',
          ),
        );
      } else {
        print('setting member[1] is typing');
        _typingMessageUseCase.execute(
          state.members![1].copyWith(
            isTyping: 'true',
          ),
        );
      }
    }
  }

  Future<void> _onDeleteMessageEvent(
    DeleteMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    _deleteMessageUseCase.execute(event.message);
    emit(
      state.copyWith(
        messages: state.messages,
        isTyping: false,
      ),
    );
  }

  Future<void> _onDeleteChatEvent(
    DeleteChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    _deleteChatUseCase.execute(event.chatId);
  }
}

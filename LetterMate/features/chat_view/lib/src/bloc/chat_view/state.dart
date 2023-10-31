part of 'bloc.dart';

class ChatState extends Equatable {
  final List<MessageModel>? messages;
  final List<ChatMemberModel>? members;
  final bool isLoading;
  final bool isEditMode;
  final String editId;
  final bool isTyping;
  final bool isCompanionTyping;
  final String pickedFile;
  final String chatName;
  final String chatId;
  final String userName;

  const ChatState({
    this.messages = const [],
    this.members = const [],
    this.isLoading = true,
    this.isEditMode = false,
    this.editId = '',
    this.isTyping = false,
    this.isCompanionTyping = false,
    this.pickedFile = '',
    this.chatName = '',
    this.chatId = '',
    this.userName = '',
  });

  ChatState copyWith({
    List<MessageModel>? messages,
    List<ChatMemberModel>? members,
    bool? isLoading,
    bool? isEditMode,
    String? editId,
    bool? isTyping,
    bool? isCompanionTyping,
    String? pickedFile,
    String? chatName,
    String? chatId,
    String? userName,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      members: members ?? this.members,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
      editId: editId ?? this.editId,
      isTyping: isTyping ?? this.isTyping,
      isCompanionTyping: isCompanionTyping ?? this.isCompanionTyping,
      pickedFile: pickedFile ?? this.pickedFile,
      chatName: chatName ?? this.chatName,
      chatId: chatId ?? this.chatId,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        messages,
        members,
        isLoading,
        isEditMode,
        editId,
        isTyping,
        isCompanionTyping,
        pickedFile,
        chatName,
        chatId,
        userName,
      ];
}

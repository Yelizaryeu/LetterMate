import 'package:bloc/bloc.dart';
import 'package:data/entity/chat/chat_entity.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DatabaseRepository databaseRepository;

  ChatBloc({required this.databaseRepository}) : super(ChatEmptyState()) {
    on<ChatFetchedEvent>(_fetchChatData);
    on<ChatUpdateEvent>(_updateChatData);
    on<SendMessageEvent>(_sendMessage);
  }

  _updateChatData(ChatUpdateEvent event, Emitter<ChatState> emit) async {
    await databaseRepository.updateChatData(event.chatEntity);
  }

  _sendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    await databaseRepository.sendMessage(event.chatId, event.chatMessageData);
  }

  _fetchChatData(ChatFetchedEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    print('trying to get chatEntity');
    ChatEntity? chatEntity = await databaseRepository.getUserChat(event.chatId);
    //print('got this entity: ${chatEntity.chatId}');
    //final currentUserData = event.userEntity;
    //await databaseRepository.updateUserData(currentUserData);
    //UserEntity userData = await databaseRepository.getUserData(currentUserData.uid);
    print('emitting loaded state');
    //emit(ChatLoadedState(chatEntity));
  }
}

// class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
//   final DatabaseService databaseService;
//
//   DatabaseBloc({required this.databaseService}) : super(DatabaseEmptyState()) {
//     on<LoadDatabaseEvent>((event, emit) async {
//       if (state is DatabaseLoadingState) return;
//
//       emit(DatabaseLoadingState());
//
//       final userModel = await databaseService.getUserData(FirebaseAuth.instance.currentUser!.uid);
//
//       emit(DatabaseLoadedState(userModel));
//     });
//
//     on<AddDatabaseEvent>((event, emit) async {
//
//       final userModel = await databaseService.gettingUserData(FirebaseAuth.instance.currentUser!.uid);
//
//       await databaseService.updateUserData(userModel.displayName, userModel.photoURL);
//
//
//     });
//   }
// }

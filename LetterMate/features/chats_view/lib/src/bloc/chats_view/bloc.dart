import 'package:bloc/bloc.dart';
import 'package:core/di/locator_service.dart';
import 'package:domain/models/user/user_model.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:data/entity/user/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


part 'event.dart';
part 'state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final DatabaseRepository databaseRepository;

  ChatsBloc({required this.databaseRepository}) : super(ChatsEmptyState()) {
    on<ChatsFetchedEvent>(_fetchChatsData);
  }

  _fetchChatsData(ChatsFetchedEvent event, Emitter<ChatsState> emit) async {
    //final currentUserData = serviceLocator.get<UserEntity>(instanceName: 'currentUser');
    final chats = databaseRepository.gettingUserData();
    //await databaseRepository.updateUserData(currentUserData);
    //UserModel userData = await databaseRepository.gettingUserData(currentUserData.uid);
    emit(ChatsLoadedState(chats));
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
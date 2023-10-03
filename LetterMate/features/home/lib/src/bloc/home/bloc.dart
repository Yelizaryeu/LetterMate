import 'package:bloc/bloc.dart';
import 'package:core/di/locator_service.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:data/entity/user/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';


class ProfileBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository databaseRepository;

  ProfileBloc({required this.databaseRepository}) : super(DatabaseEmptyState()) {
    //on<DatabaseFetchedEvent>(_fetchUserData);
  }

  // _fetchUserData(DatabaseFetchedEvent event, Emitter<DatabaseState> emit) async {
  //   final currentUserData = serviceLocator.get<UserEntity>(instanceName: 'currentUser');
  //   await databaseRepository.updateUserData(currentUserData);
  //   UserEntity userData = await databaseRepository.gettingUserData(currentUserData.uid);
  //   emit(DatabaseLoadedState(userData,event.displayName));
  // }
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
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/di/locator_service.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:data/entity/user/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DatabaseRepository databaseRepository;

  ProfileBloc({required this.databaseRepository}) : super(ProfileEmptyState()) {
    on<ProfileFetchedEvent>(_fetchUserData);
    on<ProfileUpdateEvent>(_updateUserData);
    on<ProfileAvatarEvent>(_updateUserAvatar);
  }

  _updateUserData(ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    await databaseRepository.updateUserData(event.userEntity);
  }

  _updateUserAvatar(ProfileAvatarEvent event, Emitter<ProfileState> emit) async {
    await databaseRepository.updateUserAvatar(event.userEntity, event.avatar, event.path);
  }

  _fetchUserData(ProfileFetchedEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    UserEntity userData = await databaseRepository.getUserData(event.uid);
    //final currentUserData = event.userEntity;
    //await databaseRepository.updateUserData(currentUserData);
    //UserEntity userData = await databaseRepository.getUserData(currentUserData.uid);
    emit(ProfileLoadedState(userData));
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
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecases/update_avatar_usecase.dart';
import 'package:domain/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserData _updateUserData;
  final UpdateUserAvatar _updateUserAvatar;
  final GetUserData _getUserData;
  final DeleteUserUseCase _deleteUserUseCase;

  ProfileBloc({
    required UpdateUserData updateUserData,
    required UpdateUserAvatar updateUserAvatar,
    required GetUserData getUserData,
    required DeleteUserUseCase deleteUserUseCase,
  })  : _updateUserData = updateUserData,
        _updateUserAvatar = updateUserAvatar,
        _getUserData = getUserData,
        _deleteUserUseCase = deleteUserUseCase,
        super(
          const ProfileState(
            displayName: '',
            uuid: '',
            photoURL: '',
          ),
        ) {
    on<ProfileInitEvent>(_onProfileInitEvent);
    on<ProfileUpdateEvent>(_onProfileUpdateEvent);
    on<ProfileAvatarEvent>(_onProfileAvatarEvent);
    on<ProfileDeleteEvent>(_onDeleteUserEvent);
    add(ProfileInitEvent());
  }

  Future<void> _onProfileInitEvent(
    ProfileInitEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final UserModel user = await _getUserData.execute(const NoParams());
    emit(
      state.copyWith(
        displayName: user.displayName,
        photoURL: user.photoURL,
        uuid: user.uuid,
      ),
    );
  }

  Future<void> _onProfileUpdateEvent(
    ProfileUpdateEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final UserModel user = await _getUserData.execute(const NoParams());
    user.displayName = event.displayName;
    user.uuid = event.uuid;
    print('updating to this user: ${user.displayName}');
    _updateUserData.execute(user);
    emit(
      state.copyWith(
        displayName: event.displayName,
        uuid: event.uuid,
      ),
    );
  }

  Future<void> _onDeleteUserEvent(
    ProfileDeleteEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _deleteUserUseCase.execute(const NoParams());
  }

  Future<void> _onProfileAvatarEvent(
    ProfileAvatarEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await _updateUserAvatar.execute(event.avatar);
    final UserModel user = await _getUserData.execute(const NoParams());
    emit(
      state.copyWith(
        photoURL: user.photoURL,
      ),
    );
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

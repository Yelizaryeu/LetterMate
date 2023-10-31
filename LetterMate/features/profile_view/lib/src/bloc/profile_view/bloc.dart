import 'dart:io';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecases/update_avatar_usecase.dart';
import 'package:domain/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'event.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserDataUseCase _updateUserDataUseCase;
  final UpdateUserAvatarUseCase _updateUserAvatarUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  final DeleteUserUseCase _deleteUserUseCase;

  ProfileBloc({
    required UpdateUserDataUseCase updateUserDataUseCase,
    required UpdateUserAvatarUseCase updateUserAvatarUseCase,
    required GetUserDataUseCase getUserDataUseCase,
    required DeleteUserUseCase deleteUserUseCase,
  })  : _updateUserDataUseCase = updateUserDataUseCase,
        _updateUserAvatarUseCase = updateUserAvatarUseCase,
        _getUserDataUseCase = getUserDataUseCase,
        _deleteUserUseCase = deleteUserUseCase,
        super(const ProfileState()) {
    on<ProfileInitEvent>(_onProfileInitEvent);
    on<ProfileUpdateEvent>(_onProfileUpdateEvent);
    on<ProfileSelectAvatarEvent>(_onProfileSelectAvatarEvent);
    on<ProfileAvatarEvent>(_onProfileAvatarEvent);
    on<ProfileDeleteEvent>(_onProfileDeleteEvent);
    on<ProfileEditModeEvent>(_onProfileEditModeEvent);
    add(ProfileInitEvent());
  }

  Future<void> _onProfileInitEvent(
    ProfileInitEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final UserModel user = await _getUserDataUseCase.execute(const NoParams());
    emit(
      state.copyWith(
        displayName: user.displayName,
        photoURL: user.photoURL,
        uuid: user.uuid,
        isLoading: false,
      ),
    );
  }

  Future<void> _onProfileUpdateEvent(
    ProfileUpdateEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final UserModel user = await _getUserDataUseCase.execute(const NoParams());
    _updateUserDataUseCase.execute(
      user.copyWith(
        displayName: event.displayName,
        uuid: event.uuid,
      ),
    );
    emit(
      state.copyWith(
        displayName: event.displayName,
        uuid: event.uuid,
        isEditMode: false,
      ),
    );
  }

  Future<void> _onProfileEditModeEvent(
    ProfileEditModeEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isEditMode: true));
  }

  Future<void> _onProfileSelectAvatarEvent(
    ProfileSelectAvatarEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    emit(
      state.copyWith(
        pickedFile: result.files.first.path,
      ),
    );
  }

  Future<void> _onProfileDeleteEvent(
    ProfileDeleteEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _deleteUserUseCase.execute(const NoParams());
  }

  Future<void> _onProfileAvatarEvent(
    ProfileAvatarEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await _updateUserAvatarUseCase.execute(event.avatar);
    final UserModel user = await _getUserDataUseCase.execute(const NoParams());
    emit(
      state.copyWith(
        photoURL: user.photoURL,
        pickedFile: '',
      ),
    );
  }
}

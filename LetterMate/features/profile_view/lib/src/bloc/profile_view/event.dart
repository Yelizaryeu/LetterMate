part of 'bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileFetchedEvent extends ProfileEvent {
  final String uid;
  const ProfileFetchedEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}

class ProfileUpdateEvent extends ProfileEvent {
  final UserEntity userEntity;
  const ProfileUpdateEvent(this.userEntity);

  @override
  List<Object?> get props => [userEntity];
}

class ProfileDeleteEvent extends ProfileEvent {}

class ProfileAvatarEvent extends ProfileEvent {
  final File avatar;
  final String path;
  const ProfileAvatarEvent(this.avatar, this.path);

  @override
  List<Object?> get props => [avatar];
}
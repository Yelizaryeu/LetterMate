part of 'bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileInitEvent extends ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent {
  final String displayName;
  final String uuid;
  const ProfileUpdateEvent(this.displayName, this.uuid);
}

class ProfileDeleteEvent extends ProfileEvent {}

class ProfileAvatarEvent extends ProfileEvent {
  final File avatar;
  const ProfileAvatarEvent(this.avatar);
}

part of 'bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileEmptyState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserEntity userData;
  const ProfileLoadedState(this.userData);


}

class ProfileErrorState extends ProfileState {
  final String message;

  const ProfileErrorState({required this.message});
}


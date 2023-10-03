part of 'bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object?> get props => [];
}

class DatabaseEmptyState extends DatabaseState {}

class DatabaseLoadedState extends DatabaseState {
  final UserEntity userData;
  final String? displayName;
  const DatabaseLoadedState(this.userData,this.displayName);

  @override
  List<Object?> get props => [userData,displayName];
}

class DatabaseErrorState extends DatabaseState {
  final String message;

  DatabaseErrorState({required this.message});
}


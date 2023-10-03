part of 'bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object?> get props => [];
}

class DatabaseFetchedEvent extends DatabaseEvent {
  final String? displayName;
  const DatabaseFetchedEvent(this.displayName);
  @override
  List<Object?> get props => [displayName];
}
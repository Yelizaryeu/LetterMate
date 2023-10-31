part of 'bloc.dart';

class ChatsState extends Equatable {
  final UserModel? userModel;
  final bool isLoading;
  final bool error;

  const ChatsState({
    this.userModel,
    this.isLoading = true,
    this.error = false,
  });

  ChatsState copyWith({UserModel? userModel, bool? isLoading, bool? error}) {
    return ChatsState(
      userModel: userModel ?? this.userModel,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        isLoading,
        userModel,
        error,
      ];
}

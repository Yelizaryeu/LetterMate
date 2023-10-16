part of 'bloc.dart';

class ProfileState extends Equatable {
  final String displayName;
  final String uuid;
  final String photoURL;

  const ProfileState({
    required this.displayName,
    required this.uuid,
    required this.photoURL,
  });

  ProfileState copyWith({
    String? displayName,
    String? uuid,
    String? photoURL,
  }) {
    return ProfileState(
      displayName: displayName ?? this.displayName,
      uuid: uuid ?? this.uuid,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  @override
  List<Object> get props => <Object>[
        displayName,
        uuid,
        photoURL,
      ];
}

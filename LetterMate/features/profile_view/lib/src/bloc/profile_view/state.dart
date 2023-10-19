part of 'bloc.dart';

class ProfileState extends Equatable {
  final String displayName;
  final String uuid;
  final String photoURL;
  final bool isLoading;
  final bool isEditMode;
  final String pickedFile;

  const ProfileState({
    this.displayName = '',
    this.uuid = '',
    this.photoURL = '',
    this.isLoading = true,
    this.isEditMode = false,
    this.pickedFile = '',
  });

  ProfileState copyWith({
    String? displayName,
    String? uuid,
    String? photoURL,
    bool? isLoading,
    bool? isEditMode,
    String? pickedFile,
  }) {
    return ProfileState(
        displayName: displayName ?? this.displayName,
        uuid: uuid ?? this.uuid,
        photoURL: photoURL ?? this.photoURL,
        isLoading: isLoading ?? this.isLoading,
        isEditMode: isEditMode ?? this.isEditMode,
        pickedFile: pickedFile ?? this.pickedFile);
  }

  @override
  List<Object> get props => <Object>[
        displayName,
        uuid,
        photoURL,
        isLoading,
        isEditMode,
        pickedFile,
      ];
}

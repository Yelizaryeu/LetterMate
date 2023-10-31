import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String uuid,
    required String uid,
    required String displayName,
    required String photoURL,
    List<String>? chats,
    required String fCMToken,
  }) = _UserModel;
}

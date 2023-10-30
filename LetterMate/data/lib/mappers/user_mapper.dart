import 'package:domain/models/user/user_model.dart';

import '../entities/user/user_entity.dart';

abstract class UserMapper {
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      uid: model.uid,
      uuid: model.uuid,
      displayName: model.displayName,
      photoURL: model.photoURL,
      chats: model.chats,
      fCMToken: model.fCMToken,
    );
  }

  static UserModel toModel(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      uuid: entity.uuid,
      displayName: entity.displayName,
      photoURL: entity.photoURL,
      chats: entity.chats,
      fCMToken: entity.fCMToken,
    );
  }
}

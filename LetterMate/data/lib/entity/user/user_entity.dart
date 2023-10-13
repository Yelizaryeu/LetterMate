import 'package:domain/models/user/user_model.dart';

class UserEntity extends UserModel {

  UserEntity(
      {required super.uuid,
        required super.uid,
        required super.displayName,
        required super.photoURL,
        required super.chats,
        required super.fCMToken,
      });


  factory  UserEntity.fromJson(Map<String, dynamic> json) {

    return UserEntity(
      uid: json['uid'],
      uuid: json['uuid'],
      displayName: json['displayName'] ?? 'Anon',
      photoURL: json['photoURL'],
      chats: json['chats'],
      fCMToken: json['fCMToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid' : uid,
      'uuid' : uuid,
      'displayName': displayName,
      'photoURL': photoURL,
      'chats' : chats,
      'fCMToken': fCMToken,
    };
  }

  @override
  String toString() {
    return 'UUID: $uuid, Name: $displayName';
  }
}
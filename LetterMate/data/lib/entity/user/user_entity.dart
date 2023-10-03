import 'package:domain/models/user/user_model.dart';

class UserEntity extends UserModel {

  UserEntity(
      {required super.uuid,
        required super.uid,
        required super.displayName,
        required super.photoURL,
        required super.chats
      });


  factory  UserEntity.fromJson(Map<String, dynamic> json, uid) {
    String photoURL = json['photoURL'];
    // if (photoURL == '') {
    //   photoURL = 'assets/images/default_profile.jpg';
    //   //photoURL = 'gs://lettermate-ed713.appspot.com/default_profile.jpg';
    // }
    //List<dynamic> chats = json['chats'];
    return UserEntity(
      uid: uid,
      uuid: json['uuid'],
      displayName: json['displayName'] ?? 'Anon',
      photoURL: photoURL,
      chats: json['chats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid' : uuid,
      'displayName': displayName,
      'photoURL': photoURL,
      'chats' : chats,
    };
  }

  @override
  String toString() {
    return 'UUID: $uuid, Name: $displayName';
  }
}
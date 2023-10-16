import 'dart:typed_data';

class UserModel {
String uuid;
final String uid;
String displayName;
String photoURL;
List<dynamic>? chats;
String fCMToken;

UserModel({
  required this.uuid,
  required this.uid,
  required this.displayName,
  required this.photoURL,
  required this.chats,
  required this.fCMToken,
});
}
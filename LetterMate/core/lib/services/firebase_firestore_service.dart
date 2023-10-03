import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entity/message/message_entity.dart';
import 'package:data/entity/user/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> createUser({
    required String displayName,
    required String photoURL,
    required String uuid,
    required String uid,
    required List<String> chats,
  }) async {
    final user = UserEntity(
      uid: uid,
      uuid: uuid,
      displayName: displayName,
      photoURL: photoURL,
      chats: chats
    );

    await firestore
        .collection('users')
        .doc(uuid)
        .set(user.toJson());
  }

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = MessageEntity(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = MessageEntity(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> _addMessageToChat(
      String receiverId,
      MessageEntity message,
      ) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(message.toJson());
  }

  static Future<void> updateUserData(
      Map<String, dynamic> data) async =>
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

  // static Future<List<UserEntity>> searchUser(
  //     String uid) async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where("uid", isGreaterThanOrEqualTo: uid)
  //       .get();
  //
  //   return snapshot.docs
  //       .map((doc) => UserEntity.fromJson(doc.data()))
  //       .toList();
  // }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entity/chat/chat_entity.dart';

import '../domain.dart';

abstract class DatabaseRepository {
  Future<void> updateUserData(UserModel user);
  Future<void> updateUserAvatar(File file);
  Future<void> updateUserName(String name);
  Future<void> updateUserUUID(String uuid);
  Future<UserModel> getUserData();
  Stream<DocumentSnapshot> gettingUserData();
  Future<ChatEntity?> getUserChat(String chatId);
  Future<void> updateChatData(ChatEntity chat);
  Future<void> deleteUserAccount();
  Future<void> sendMessage(String chatId, Map<String, dynamic> chatMessageData);
  //Future<UserEntity> gettingUserData(String uid);
}

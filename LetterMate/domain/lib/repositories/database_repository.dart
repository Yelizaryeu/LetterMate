import 'dart:io';

import 'package:data/entity/user/user_entity.dart';
import 'package:data/entity/chat/chat_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class DatabaseRepository {
  Future<void> updateUserData(UserEntity user);
  Future<void> updateUserAvatar(File file, String path);
  Future<void> updateUserName(String name);
  Future<void> updateUserUUID (String uuid);
  Future<UserEntity> getUserData();
  Stream<DocumentSnapshot> gettingUserData();
  Future<ChatEntity?> getUserChat(String chatId);
  Future<void> updateChatData(ChatEntity chat);
  Future<void> deleteUserAccount();
  Future<void> sendMessage(String chatId, Map<String, dynamic> chatMessageData);
  //Future<UserEntity> gettingUserData(String uid);
}
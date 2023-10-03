import 'dart:io';

import '../models/user/user_model.dart';
import 'package:data/entity/user/user_entity.dart';
import 'package:data/entity/chat/chat_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class DatabaseRepository {
  Future<void> updateUserData(UserEntity user);
  Future<void> updateUserAvatar(UserEntity userEntity ,File file, String path);
  Future<UserEntity> getUserData(String uid);
  Stream<DocumentSnapshot> getUserChats();
  Future<ChatEntity> getUserChat(String chatId);
  Future<void> updateUserChats(ChatEntity chat);
  Future<void> sendMessage(String chatId, Map<String, dynamic> chatMessageData);
  //Future<UserEntity> gettingUserData(String uid);
}
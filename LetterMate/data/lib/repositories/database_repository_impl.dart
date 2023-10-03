import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entity/chat/chat_entity.dart';
import 'package:domain/models/user/user_model.dart';
import 'package:domain/repositories/database_repository.dart';
import '../entity/user/user_entity.dart';
import '../providers/database_service.dart';


class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService databaseService = DatabaseService();

  DatabaseRepositoryImpl({required this.databaseService});

  @override
  Future<void> updateUserData(UserModel user) async {
    return await databaseService.updateUserData(user as UserEntity);
  }

  @override
  Future<UserEntity> getUserData(String uid) async {
    return await databaseService.getUserData(uid);
  }

  // @override
  // Future<UserEntity> gettingUserData(String uid) async {
  //   return await databaseService.gettingUserData(uid);
  // }

  @override
  Future<void> updateUserAvatar(UserEntity userEntity, File file, String path) async {
    await databaseService.updateUserPhoto(userEntity, file, path);

  }

  @override
  Stream<DocumentSnapshot> getUserChats() {
    return databaseService.getUserChats();
  }

  @override
  Future<ChatEntity> getUserChat(String chatId) {
    return databaseService.getChat(chatId);
  }

  @override
  Future<void> updateUserChats(ChatEntity chat) async {
    return await databaseService.updateUserChat(chat);
  }

  @override
  Future<void> sendMessage(String chatId, Map<String, dynamic> chatMessageData) async {
    return await databaseService.sendMessage(chatId, chatMessageData);
  }

}
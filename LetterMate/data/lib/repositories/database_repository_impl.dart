import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/di/app_di.dart';
import 'package:data/entity/chat/chat_entity.dart';
import 'package:domain/models/user/user_model.dart';
import 'package:domain/repositories/database_repository.dart';
import '../entity/user/user_entity.dart';
import '../providers/database_service.dart';


class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService databaseService = appLocator<DatabaseService>();

  DatabaseRepositoryImpl({required this.databaseService});

  @override
  Future<void> updateUserData(UserModel user) async {
    print ('updating user in repository');
    return await databaseService.updateUserData(user as UserEntity);
  }

  @override
  Future<UserEntity> getUserData() async {
    return await databaseService.getUserData();
  }

  // @override
  // Future<UserEntity> gettingUserData(String uid) async {
  //   return await databaseService.gettingUserData(uid);
  // }

  @override
  Future<void> updateUserAvatar(File file, String path) async {
    print('updating photo in repository');
    return await databaseService.updateUserPhoto(file, path);
  }

  @override
  Stream<DocumentSnapshot> gettingUserData() {
    return databaseService.gettingUserData();
  }

  @override
  Future<ChatEntity?> getUserChat(String chatId) {
    return databaseService.getChat(chatId);
  }

  @override
  Future<void> updateChatData(ChatEntity chat) async {
    return await databaseService.updateChatData(chat);
  }

  @override
  Future<void> sendMessage(String chatId, Map<String, dynamic> chatMessageData) async {
    return await databaseService.sendMessage(chatId, chatMessageData);
  }

  @override
  Future<void> deleteUserAccount() async {
    await databaseService.deleteAccount();
  }

  @override
  Future<void> updateUserName(String name) async {
    databaseService.updateUserName(name);
  }

  @override
  Future<void> updateUserUUID(String uuid) async {
    databaseService.updateUserUUID(uuid);
  }

}
import 'dart:io';

import '../domain.dart';

abstract class DatabaseRepository {
  Future<void> updateUserData(UserModel user);

  Future<void> updateUserAvatar(File file);

  Future<void> updateUserName(String name);

  Future<void> updateUserUUID(String uuid);

  Future<bool> checkUserExistence(String uuid);

  Future<UserModel> getUserData();

  Stream<UserModel> gettingUserData();

  Stream<List<MessageModel>?>? gettingChatMessages(String chatId);

  Stream<List<ChatMemberModel>?>? gettingChatMembers(String chatId);

  Future<ChatModel?> getUserChat(String chatId);

  Future<void> updateChatData(ChatModel chat);

  Future<void> createChat(String companionId);

  Future<void> deleteUserAccount();

  Future<void> sendMessage(MessageModel message);

  Future<void> sendFileMessage(MessageModel messageModel);

  Future<void> deleteMessage(MessageModel message);

  Future<void> editMessage(MessageModel message);

  Future<void> deleteChat(String chatId);

  Future<void> updateChatMember(ChatMemberModel chatMemberModel);
//Future<UserEntity> gettingUserData(String uid);
}

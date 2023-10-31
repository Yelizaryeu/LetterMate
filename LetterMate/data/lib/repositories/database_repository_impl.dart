import 'dart:io';

import 'package:data/entities/entities.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart';

import '../providers/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseService _databaseService;

  DatabaseRepositoryImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  @override
  Future<void> updateUserData(UserModel user) async {
    print('updating user in repository');
    return await _databaseService.updateUserData(user as UserEntity);
  }

  @override
  Future<UserModel> getUserData() async {
    return UserMapper.toModel(await _databaseService.getUserData());
  }

  // @override
  // Future<UserEntity> gettingUserData(String uid) async {
  //   return await _databaseService.gettingUserData(uid);
  // }

  @override
  Future<void> updateUserAvatar(File file) async {
    print('updating photo in repository');
    return await _databaseService.updateUserPhoto(file);
  }

  @override
  Stream<UserModel> gettingUserData() {
    return _databaseService.gettingUserData();
  }

  @override
  Stream<List<MessageModel>?>? gettingChatMessages(String chatId) {
    return _databaseService.gettingChatMessages(chatId);
    // databaseService.gettingChatMessages(widget.chatId).then((val) {
    //   setState(() {
    //     messages = val;
    //   });
    // });
  }

  @override
  Future<ChatModel?> getUserChat(String chatId) async {
    ChatEntity? chat = await _databaseService.getChat(chatId);
    return chat == null ? null : ChatMapper.toModel(chat);
  }

  @override
  Future<void> updateChatData(ChatModel chat) async {
    return await _databaseService.updateChatData(chat);
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    return await _databaseService.sendMessage(message);
  }

  @override
  Future<void> deleteUserAccount() async {
    await _databaseService.deleteAccount();
  }

  @override
  Future<void> updateUserName(String name) async {
    _databaseService.updateUserName(name);
  }

  @override
  Future<void> updateUserUUID(String uuid) async {
    _databaseService.updateUserUUID(uuid);
  }

  @override
  Future<void> createChat(String companionId) async {
    _databaseService.createChat(companionId);
  }

  @override
  Future<bool> checkUserExistence(String uuid) {
    return _databaseService.checkExist(uuid);
  }

  @override
  Future<void> deleteMessage(MessageModel message) {
    return _databaseService.deleteMessage(message.chatId, message.time.toString());
  }

  @override
  Future<void> editMessage(MessageModel message) {
    return _databaseService.editMessage(
        chatId: message.chatId, message: message.message, messageId: message.time.toString());
  }

  @override
  Future<void> deleteChat(String chatId) {
    return _databaseService.deleteChat(chatId);
  }

  // @override
  // Future<void> typingMessage() {
  //   return _databaseService.updateChatMember(chatId, chatMemberEntity)
  // }

  @override
  Stream<List<ChatMemberModel>?>? gettingChatMembers(String chatId) {
    return _databaseService.gettingChatMembers(chatId);
  }

  @override
  Future<void> updateChatMember(ChatMemberModel chatMemberModel) {
    return _databaseService.updateChatMember(ChatMemberMapper.toEntity(chatMemberModel));
  }

  @override
  Future<void> sendFileMessage(MessageModel messageModel) async {
    print('calling sendUserFile from database');
    return await _databaseService.sendUserFile(messageModel);
  }
}

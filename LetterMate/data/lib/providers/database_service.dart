import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entities/entities.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference chatCollection = FirebaseFirestore.instance.collection("chats");
  final _firebaseMessaging = FirebaseMessaging.instance;

  //init push notification
  Future initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // get fCMToken for current user
  Future<String> getFCMToken() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    return fCMToken!;
  }

  Future<void> initNotifications() async {
    final fCMToken = await getFCMToken();
    print("Token: $fCMToken");
    initPushNotification();
  }

  // send push notification to specified fCMToken
  Future<void> sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAo1yfBzc:APA91bHbzryHl58Whkp5LtjeggzlXckMnd-rl5obhpivxi9IlQgDBrTfYLYMzdNeQkOgsqJ1aFiRPEb3vXBVeRHjPbKVKz7dDM6MEDrA2ozjxWNowRxq8si3SDUdmr2YV_8nHxHwzxGF'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'android_channed_id': 'dbfood',
            },
            'to': token,
          },
        ),
      );
    } catch (e) {}
  }

  // update user data with given userEntity and update it's entities in chats
  Future<void> updateUserData(UserEntity userEntity) async {
    await userCollection.doc(userEntity.uid).set(userEntity.toJson());
    if (userEntity.chats != [] && userEntity.chats != null) {
      for (String chat in userEntity!.chats!) {
        await updateChatMember(ChatMemberEntity(
            uid: userEntity.uid,
            uuid: userEntity.uuid,
            name: userEntity.displayName,
            chatId: getId(chat),
            photoURL: userEntity.photoURL,
            fCMToken: userEntity.fCMToken,
            isTyping: 'false'));
        await updateChatMessagesSender(getId(chat), uid, userEntity.displayName);
      }
    }
  }

  Future<void> updateUserName(String name) async {
    await userCollection.doc(uid).update({'displayName': name});
    final user = await getUserData();
    await updateUserData(user);
  }

  Future<void> updateUserUUID(String uuid) async {
    await userCollection.doc(uid).update({'uuid': uuid});
    final user = await getUserData();
    await updateUserData(user);
  }

  // update chat in chatCollection with given chatEntity
  Future<void> updateChatData(ChatModel chatModel) async {
    return await chatCollection.doc(chatModel.chatId).set(ChatMapper.toEntity(chatModel).toJson());
  }

  // update user photoURL, upload photo to firebase storage and set downloadURL to photoURL field
  Future<void> updateUserPhoto(File file) async {
    final path = '$uid/files/avatar/';
    await FirebaseStorage.instance.ref().child(path).putFile(file);
    await userCollection.doc(uid).update({'photoURL': await FirebaseStorage.instance.ref(path).getDownloadURL()});
    final user = await getUserData();
    return await updateUserData(user);
  }

  // get UserEntity for current user
  Future<UserEntity> getUserData() async {
    final DocumentSnapshot doc = await userCollection.doc(uid).get();
    UserEntity user;

    print('getting user data');
    if (doc.data() == null) {
      String photoURL = await FirebaseStorage.instance.ref('default_profile.jpg').getDownloadURL();
      user = UserEntity(
        uuid: uid,
        uid: uid,
        displayName: 'Anon',
        photoURL: photoURL,
        chats: [],
        fCMToken: '',
      );
      user.copyWith(fCMToken: await getFCMToken());
      await DatabaseService(uid: uid).updateUserData(user);
    } else {
      user = UserEntity.fromJson(doc.data() as Map<String, dynamic>);
      user.copyWith(fCMToken: await getFCMToken());
      await DatabaseService(uid: uid).updateUserData(user);
    }
    return user;
  }

  Stream? _userData;
  final StreamController<UserModel> _userDataModels = StreamController.broadcast();

  // getting a stream of userCollection
  Stream<UserModel> gettingUserData() {
    _userData ??= userCollection.doc(uid).snapshots();
    _userData?.listen((event) {
      _userDataModels.add(UserMapper.toModel(UserEntity.fromJson(event.data())));
    });
    return _userDataModels.stream;
  }

  Future<UserEntity> getUserByUuid(String uuid) async {
    final Query<Object?> query = userCollection.where(
      'uuid',
      isEqualTo: uuid,
    );
    final QuerySnapshot<Object?> data = await query.get();

    return UserEntity.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }

  // creating a chat
  Future createChat(String companionId) async {
    final companion = await getUserByUuid(companionId);
    final currentUser = await getUserData();

    DocumentReference chatDocumentReference = await chatCollection.add(ChatEntity(
      chatId: "",
      members: [],
      recentMessage: "",
      recentMessageSender: "",
      recentMessageTime: null,
    ).toJson());

    // update the members
    final ChatMemberEntity currentUserMember = ChatMemberEntity(
        uid: currentUser.uid,
        uuid: currentUser.uuid,
        name: currentUser.displayName,
        chatId: chatDocumentReference.id,
        photoURL: currentUser.photoURL,
        fCMToken: currentUser.fCMToken,
        isTyping: 'false');
    final ChatMemberEntity companionMember = ChatMemberEntity(
        uid: companion.uid,
        uuid: companion.uuid,
        name: companion.displayName,
        chatId: chatDocumentReference.id,
        photoURL: companion.photoURL,
        fCMToken: companion.fCMToken,
        isTyping: 'false');

    print(currentUserMember);
    await chatDocumentReference.update(
      {
        "chatId": chatDocumentReference.id,
      },
    );

    chatCollection.doc(chatDocumentReference.id).collection("messages").doc("initial message").set(MessageEntity(
          senderId: "LetterMate",
          senderName: "LetterMate",
          message: "${currentUserMember.name} created conversation",
          chatId: chatDocumentReference.id,
          time: DateTime.now().millisecondsSinceEpoch,
          messageType: 'text',
          isEdited: false,
          isDeleted: false,
        ).toJson());
    chatCollection.doc(chatDocumentReference.id).update({
      "recentMessage": "${currentUserMember.name} created conversation",
      "recentMessageSender": "LetterMate",
      "recentMessageTime": DateTime.now().millisecondsSinceEpoch,
    });

    await chatCollection.doc(chatDocumentReference.id).update({
      'members': [currentUserMember.toJson(), companionMember.toJson()]
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    await userDocumentReference.update({
      "chats": FieldValue.arrayUnion(["${chatDocumentReference.id}_${companion.displayName}"])
    });

    DocumentReference companionDocumentReference = userCollection.doc(companion.uid);
    return await companionDocumentReference.update({
      "chats": FieldValue.arrayUnion(["${chatDocumentReference.id}_${currentUser.displayName}"])
    });
  }

  // check if there is a doc in userCollection with given uuid
  Future<bool> checkExist(String uuid) async {
    try {
      await userCollection.where("uuid", isEqualTo: uuid).get();
      return true;
    } catch (e) {
      return false;
    }
  }

  final Map<String, Stream> _messages = {};
  final Map<String, StreamController<List<MessageModel>?>> _messagesModels = {};

  // getting messages in the chat
  Stream<List<MessageModel>?>? gettingChatMessages(String chatId) {
    _messages[chatId] = chatCollection.doc(chatId).collection("messages").orderBy("time").snapshots();

    _messagesModels[chatId] = StreamController.broadcast();
    _messages[chatId]?.listen((event) {
      if (!(_messagesModels[chatId]?.isClosed ?? false)) {
        List<MessageModel> listOfMessages = [];
        for (var message in event.docs) {
          listOfMessages.add(MessageMapper.toModel(MessageEntity.fromJson(message.data())));
        }
        _messagesModels[chatId]?.add(listOfMessages);
        // _messagesModels[chatId]
        //     ?.add(event?.docs?.forEach((e) => MessageMapper.toModel(MessageEntity.fromJson(e.data())))?.toList());
      }
    });
    return _messagesModels[chatId]?.stream;
  }

  // get chat entity
  Future<ChatEntity?> getChat(String chatId) async {
    final DocumentSnapshot doc = await chatCollection.doc(chatId).get();
    if (doc.data() != null) {
      ChatEntity chatEntity = ChatEntity.fromJson(doc.data() as Map<String, dynamic>);
      return chatEntity;
    } else {
      return null;
    }
  }

  // update chatMemberEntity in the chat
  updateChatMember(ChatMemberEntity chatMemberEntity) async {
    List<ChatMemberEntity> members = await getChatMembers(chatMemberEntity.chatId);
    for (int i = 0; i <= members.length - 1; i++) {
      if (chatMemberEntity.uid == members[i].uid) {
        members[i] = members[i].copyWith(
          name: chatMemberEntity.name,
          uuid: chatMemberEntity.uuid,
          isTyping: chatMemberEntity.isTyping,
          photoURL: chatMemberEntity.photoURL,
        );
      }
    }
    await chatCollection.doc(chatMemberEntity.chatId).update({
      'members': [members[0].toJson(), members[1].toJson()]
    });
  }

  // update sender in messages
  updateChatMessagesSender(String chatId, String uid, String sender) async {
    final doc = await chatCollection.doc(chatId).collection('messages').get();
    final messages = doc.docs;
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in messages) {
      Map<String, dynamic> message = doc.data();
      if (message['senderId'] == uid) {
        await chatCollection
            .doc(chatId)
            .collection("messages")
            .doc(message['time'].toString())
            .update({'senderName': sender});
      }
    }
  }

  // getting a stream of chat
  final Map<String, Stream> _members = {};
  final Map<String, StreamController<List<ChatMemberModel>?>> _membersModels = {};

  Stream<List<ChatMemberModel>?>? gettingChatMembers(chatId) {
    _members[chatId] = chatCollection.doc(chatId).snapshots();

    _membersModels[chatId] = StreamController.broadcast();
    _members[chatId]?.listen((event) {
      if (!(_membersModels[chatId]?.isClosed ?? false)) {
        List<ChatMemberModel> listOfMembers = [];

        for (Map<String, dynamic> member in event.data()['members']) {
          listOfMembers.add(ChatMemberMapper.toModel(ChatMemberEntity.fromJson(member)));
        }
        _membersModels[chatId]?.add(listOfMembers);

        // _membersModels[chatId]
        //     ?.add(event?.docs?.forEach((e) => ChatMemberMapper.toModel(ChatMemberEntity.fromJson(e.data())))?.toList());
      }
    });
    return _membersModels[chatId]?.stream;
  }

  // get chat members
  Future<List<ChatMemberEntity>> getChatMembers(chatId) async {
    DocumentSnapshot doc = await chatCollection.doc(chatId).get();
    Map<String, dynamic> chat = doc.data() as Map<String, dynamic>;
    List<ChatMemberEntity> members = [];
    for (Map<String, dynamic> member in chat['members']) {
      members.add(ChatMemberEntity.fromJson(member));
    }
    return members;
  }

  // send message
  sendMessage(MessageModel message) async {
    chatCollection.doc(message.chatId).collection("messages").doc(message.time.toString()).set(MessageMapper.toEntity(
          message.copyWith(
            senderId: uid,
          ),
        ).toJson());
    chatCollection.doc(message.chatId).update({
      "recentMessage": message.message,
      "recentMessageSender": message.senderName,
      "recentMessageTime": message.time,
    });
    List<ChatMemberEntity> members = await getChatMembers(message.chatId);
    for (ChatMemberEntity member in members) {
      if (member.name != message.senderName) {
        sendPushMessage(member.fCMToken, message.message, "New message from ${message.senderName}");
      }
    }
  }

  // send file
  Future sendUserFile(MessageModel messageModel) async {
    print('sending image');
    final String path = '${messageModel.chatId}/files/${DateTime.now().millisecondsSinceEpoch}';
    final File file = File(messageModel.message);
    print('putting file to storage');
    await FirebaseStorage.instance.ref().child(path).putFile(file);
    final fileLink = await FirebaseStorage.instance.ref(path).getDownloadURL();
    MessageModel message = messageModel.copyWith(
      message: fileLink,
    );
    print('sending this image: $message');
    chatCollection
        .doc(message.chatId)
        .collection("messages")
        .doc(message.time.toString())
        .set(MessageMapper.toEntity(message).toJson());
    chatCollection.doc(message.chatId).update({
      "recentMessage": message.messageType,
      "recentMessageSender": message.senderName,
      "recentMessageTime": message.time,
    });
    List<ChatMemberEntity> members = await getChatMembers(message.chatId);
    for (ChatMemberEntity member in members) {
      if (member.name != message.senderName) {
        sendPushMessage(member.fCMToken, message.messageType, "New message from ${message.senderName}");
      }
    }
  }

  // edit message
  editMessage({
    required String chatId,
    required String message,
    required String messageId,
  }) async {
    await chatCollection
        .doc(chatId)
        .collection("messages")
        .doc(messageId)
        .update({'message': message, 'isEdited': true});
  }

  // delete message in chat
  deleteMessage(String chatId, String messageId) async {
    await chatCollection
        .doc(chatId)
        .collection("messages")
        .doc(messageId)
        .update({'isDeleted': true, 'message': '', 'messageType': ''});
  }

  // delete chat with all messages
  deleteChat(String chatId) async {
    final ChatEntity? chatEntity = await getChat(chatId);
    if (chatEntity != null) {
      for (ChatMemberEntity member in chatEntity.members) {
        if (member.name == chatEntity.members[0].name) {
          await userCollection.doc(member.uid).update({
            'chats': FieldValue.arrayRemove(["${chatEntity.chatId}_${chatEntity.members[1].name}"])
          });
        } else {
          await userCollection.doc(member.uid).update({
            'chats': FieldValue.arrayRemove(["${chatEntity.chatId}_${chatEntity.members[0].name}"]),
          });
        }
      }
      await chatCollection.doc(chatEntity.chatId).collection('messages').get().then((value) => {
            value.docs.forEach((element) {
              element.reference.delete();
            })
          });
      await chatCollection.doc(chatEntity.chatId).delete();
    }
  }

  // get chatId from user chat[index]
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  deleteAccount() async {
    UserEntity user = await getUserData();
    if (user.chats != [] && user.chats != null) {
      for (String chat in user!.chats!) {
        await deleteChat(getId(chat));
      }
    }
    await userCollection.doc(uid).delete();
    if (Platform.isAndroid) {
      exit(0);
      //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}

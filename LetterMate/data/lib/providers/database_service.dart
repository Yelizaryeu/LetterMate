import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entity/chat/chat_entity.dart';
import 'package:data/entity/chat_member/chat_member_entity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import '../entity/user/user_entity.dart';

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
    print('updating user in database service');
    await userCollection.doc(userEntity.uid).set(userEntity.toJson());
    if (userEntity.chats != [] && userEntity.chats != null) {
      for (String chat in userEntity!.chats!) {
        ChatEntity? chatEntity = await getChat(getId(chat));
        // if (chatEntity!.recentMessageSender == userEntity.displayName) {
        //   await chatCollection.doc(getId(chat)).update({'recentMessageSender': userEntity.displayName});
        // }
        await updateChatMember(
            getId(chat),
            ChatMemberEntity(
                uid: userEntity.uid,
                uuid: userEntity.uuid,
                name: userEntity.displayName,
                photoURL: userEntity.photoURL,
                fCMToken: userEntity.fCMToken,
                isTyping: 'false'));
        await updateChatMessagesSender(getId(chat), uid, userEntity.displayName);
      }
    }
  }

  Future<void> updateUserName(String name) async {
    print('updating name to this: $name');
    await userCollection.doc(uid).update({'displayName': name});
    final user = await getUserData();
    await updateUserData(user);
  }

  Future<void> updateUserUUID(String uuid) async {
    print('updating uuid to this: $uuid');
    await userCollection.doc(uid).update({'uuid': uuid});
    final user = await getUserData();
    await updateUserData(user);
  }

  // update chat in chatCollection with given chatEntity
  Future<void> updateChatData(ChatEntity chatEntity) async {
    return await chatCollection.doc(chatEntity.chatId).set(chatEntity.toJson());
  }

  // update user photoURL, upload photo to firebase storage and set downloadURL to photoURL field
  Future<void> updateUserPhoto(File file) async {
    final path = '$uid/files/avatar/';
    print('updating photo in database service');
    await FirebaseStorage.instance.ref().child(path).putFile(file);
    print('put photo in storage');
    await userCollection.doc(uid).update({'photoURL': await FirebaseStorage.instance.ref(path).getDownloadURL()});
    print('updated user photoURL');
    final user = await getUserData();
    print('updated photo and now update userdata');
    return await updateUserData(user);
  }

  // get UserEntity for current user
  Future<UserEntity> getUserData() async {
    final DocumentSnapshot doc = await userCollection.doc(uid).get();
    UserEntity user;

    print('getting user data');
    if (doc.data() == null) {
      String photoURL = await FirebaseStorage.instance.ref('default_profile.jpg').getDownloadURL();
      print(photoURL);
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

  // getting a stream of userCollection
  gettingUserData() async {
    return userCollection.doc(uid).snapshots();
  }

  //get userEntity by given uuid
  // Future<UserEntity> getUserById(String uuid) async {
  //   final doc = await userCollection.where("uuid", isEqualTo: uuid).get();
  //   final userData = doc.docs.first.data() as Map<String, dynamic>;
  //   final user = UserEntity.fromJson(userData);
  //   return user;
  // }

  Future<UserEntity> getUserByUuid(String uuid) async {
    final Query<Object?> query = userCollection.where(
      'uuid',
      isEqualTo: uuid,
    );
    final QuerySnapshot<Object?> data = await query.get();

    return UserEntity.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }

  // creating a chat
  Future createChat(String userName, String companionId) async {
    final companion = await getUserByUuid(companionId);
    final currentUser = await getUserData();
    final currentUserMember = ChatMemberEntity(
        uid: currentUser.uid,
        uuid: currentUser.uuid,
        name: currentUser.displayName,
        photoURL: currentUser.photoURL,
        fCMToken: currentUser.fCMToken,
        isTyping: 'false');
    final companionMember = ChatMemberEntity(
        uid: companion.uid,
        uuid: companion.uuid,
        name: companion.displayName,
        photoURL: companion.photoURL,
        fCMToken: companion.fCMToken,
        isTyping: 'false');
    DocumentReference chatDocumentReference = await chatCollection.add(ChatEntity(
      chatId: "",
      members: [currentUserMember.toJson(), companionMember.toJson()],
      recentMessage: "",
      recentMessageSender: "",
      recentMessageTime: null,
    ).toJson());

    // update the members

    await chatDocumentReference.update({
      //"members": FieldValue.arrayUnion([currentUser.uuid, companionId]),
      "chatId": chatDocumentReference.id,
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

  // getting messages in the chat
  gettingChatMessages(String chatId) async {
    return chatCollection.doc(chatId).collection("messages").orderBy("time").snapshots();
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
  updateChatMember(String chatId, ChatMemberEntity chatMemberEntity) async {
    List<dynamic> members = await getChatMembers(chatId);
    for (int i = 0; i <= members.length - 1; i++) {
      if (chatMemberEntity.uid == members[i]['uid']) {
        members[i] = chatMemberEntity.toJson();
      }
    }
    await chatCollection.doc(chatId).update({'members': members});
  }

  // update sender in messages
  updateChatMessagesSender(String chatId, String uid, String sender) async {
    final doc = await chatCollection.doc(chatId).collection('messages').get();
    final messages = doc.docs;
    for (var doc in messages) {
      Map<String, dynamic> message = doc.data();
      if (message['senderId'] == uid) {
        await chatCollection
            .doc(chatId)
            .collection("messages")
            .doc(message['time'].toString())
            .update({'sender': sender});
      }
    }
  }

  // getting a stream of chat
  gettingChatMembers(chatId) async {
    return chatCollection.doc(chatId).snapshots();
  }

  // get chat members
  Future<List<dynamic>> getChatMembers(chatId) async {
    var doc = await chatCollection.doc(chatId).get();
    var chat = doc.data() as Map<String, dynamic>;
    List<dynamic> members = chat['members'];
    return members;
  }

  // send message
  sendMessage(String chatId, Map<String, dynamic> chatMessageData) async {
    chatMessageData['senderId'] = uid;
    chatCollection.doc(chatId).collection("messages").doc(chatMessageData['time'].toString()).set(chatMessageData);
    chatCollection.doc(chatId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'],
    });
    List<dynamic> members = await getChatMembers(chatId);
    for (Map<String, dynamic> member in members) {
      if (member['name'] != chatMessageData['sender']) {
        sendPushMessage(
            member['fCMToken'], chatMessageData['message'], "New message from ${chatMessageData['sender']}");
      }
    }
  }

  // send file
  Future sendUserFile(String chatId, File file, String path, Map<String, dynamic> chatMessageData) async {
    await FirebaseStorage.instance.ref().child(path).putFile(file);
    final message = await FirebaseStorage.instance.ref(path).getDownloadURL();
    chatMessageData["message"] = message;
    chatCollection.doc(chatId).collection("messages").doc(chatMessageData['time'].toString()).set(chatMessageData);
    chatCollection.doc(chatId).update({
      "recentMessage": chatMessageData['messageType'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'],
    });
    List<dynamic> members = await getChatMembers(chatId);
    for (Map<String, dynamic> member in members) {
      if (member['name'] != chatMessageData['sender']) {
        sendPushMessage(
            member['fCMToken'], chatMessageData['messageType'], "New message from ${chatMessageData['sender']}");
      }
    }
  }

  // edit message
  editMessage(String chatId, String message, String messageId) async {
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
  deleteChat(String chatId, String chatName, String userName) async {
    final doc = await chatCollection.doc(chatId).get();
    final data = doc.data() as Map<String, dynamic>;
    final members = data["members"];
    for (Map<String, dynamic> member in members) {
      if (member['name'] == userName) {
        await userCollection.doc(member['uid']).update({
          'chats': FieldValue.arrayRemove(["${chatId}_$chatName"])
        });
      } else {
        await userCollection.doc(member['uid']).update({
          'chats': FieldValue.arrayRemove(["${chatId}_$userName"]),
        });
      }
    }
    await chatCollection.doc(chatId).collection('messages').get().then((value) => {
          value.docs.forEach((element) {
            element.reference.delete();
          })
        });
    await chatCollection.doc(chatId).delete();
  }

  // get chatId from user chat[index]
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  deleteAccount() async {
    UserEntity user = await getUserData();
    if (user.chats != [] && user.chats != null) {
      for (String chat in user!.chats!) {
        List<dynamic> members = await getChatMembers(getId(chat));
        if (members[0]['uid'] == user.uid) {
          await deleteChat(getId(chat), members[1]['name'], members[0]['name']);
        } else {
          await deleteChat(getId(chat), members[0]['name'], members[1]['name']);
        }
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

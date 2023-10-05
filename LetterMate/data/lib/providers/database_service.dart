import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/entity/chat/chat_entity.dart';
import 'package:domain/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../entity/message/message_entity.dart';
import '../entity/user/user_entity.dart';
import 'package:core/services/firebase_firestore_service.dart';

class DatabaseService extends ChangeNotifier {
  final String? uid;
  ScrollController scrollController = ScrollController();
  List<UserModel> users = [];
  UserModel? user;
  List<MessageEntity> messages = [];
  List<UserModel> search = [];


  DatabaseService({this.uid});


  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference chatCollection = FirebaseFirestore.instance.collection("chats");


  Future<void> updateUserData(UserEntity userEntity) async {
    return await userCollection.doc(userEntity.uid).set(userEntity.toJson());

    // return await userCollection.doc(uid).set({
    //   "displayName" : userModel.displayName,
    //   "photoURL" : userModel.photoURL,
    //   "chats" : [],
    // });
  }

  Future<void> updateUserChat(ChatEntity chatEntity) async {
    return await chatCollection.doc(chatEntity.chatId).set(chatEntity.toJson());
  }

  Future updateUserPhoto(UserEntity userEntity, File file, String path) async {
    await FirebaseStorage.instance.ref().child(path).putFile(file);
    userEntity.photoURL = await FirebaseStorage.instance.ref(path).getDownloadURL();
    await updateUserData(userEntity);
  }


  // get user data
  Future<UserEntity> getUserData(String uid) async {
    final DocumentSnapshot doc = await userCollection.doc(uid).get();
    UserEntity user;
    // if ((doc.data() as Map<String, dynamic>)['photoURL'] == ''){
    //   await updateUserPhoto(File('assets/images/default_profile.jpg'), '$uid/files/avatar');
    // }
    if (doc.data() == null) {
      user = UserEntity(uuid: uid, uid: uid, displayName: 'Anon', photoURL: '', chats: []);
      await DatabaseService(uid: uid).updateUserData(user);
    } else {
      user = UserEntity.fromJson(doc.data() as Map<String, dynamic>, uid);
    }
    print('got this user: $user');
    print('trying to update avatar to this file: ${user.photoURL}');
    if (user.photoURL == ''){
      user.photoURL = await FirebaseStorage.instance.ref('default_profile.jpg').getDownloadURL();
    }
    //await updateUserPhoto(File(user.photoURL), '$uid/files/avatar');
    print('updated avatar');
    print('trying to get avatar url');
    //user.photoURL = await FirebaseStorage.instance.ref('$uid/files/avatar').getDownloadURL();
    //print('trying to update photourl in firestore');
    await updateUserData(user);
    print('updated photourl in firestore');
    //user.photoURL = await FirebaseStorage.instance.ref('$uid/files/avatar').getDownloadURL();
    // if (user.photoURL == '' || user.photoURL == null) {
    //   await updateUserPhoto(File('gs://lettermate-ed713.appspot.com/default_profile.jpg'), '${user.uid}/files/avatar');
    // }
    //user.photoURL = 'assets/images/default_profile.jpg';
    return user;
  }

  //getting user data
  // Future gettingUserData(String uid) async {
  //   QuerySnapshot snapshot =
  //   await userCollection.where("uid", isEqualTo: uid).get();
  //   Uint8List? avatar = await FirebaseStorage.instance.ref('$uid/files/avatar').getData();
  //   return UserEntity.fromJson(snapshot as Map<String, dynamic>, uid);
  //
  //   // QuerySnapshot<Map<String, dynamic>> snapshot =
  //   // await userCollection.where("uid", isEqualTo: uid).get();
  //   // return snapshot.docs
  //   //     .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
  //   //     .toList();
  // }

  // get user chats
  getUserChats() async  {
    return userCollection.doc(uid).snapshots();
  }

  // creating a chat
  Future createChat(String userName, String id, String chatName, String companionId) async {
    DocumentReference chatDocumentReference = await chatCollection.add({
      "chatName": chatName,
      "chatIcon": "",
      "members": [],
      "chatId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    // update the members
    await chatDocumentReference.update({
      "members": FieldValue.arrayUnion(["$uid", companionId]),
      "chatId": chatDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    await userDocumentReference.update({
      "chats":
      FieldValue.arrayUnion(["${chatDocumentReference.id}_$chatName"])
    });

    DocumentReference companionDocumentReference = userCollection.doc(companionId);
    return await companionDocumentReference.update({
      "chats":
      FieldValue.arrayUnion(["${chatDocumentReference.id}_$chatName"])
    });
  }

  Future<bool> checkExist(String uuid) async {
    //userCollection.where("uuid", isEqualTo: uuid).get();
    final DocumentSnapshot doc = await userCollection.doc(uuid).get();
    if (doc.data() != null) {
      return true;
    } else {
      return false;
    }
  }

  // getting the chats
  getChats(String chatId) async {
    return chatCollection
        .doc(chatId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future<ChatEntity> getChat(String chatId) async {
    final DocumentSnapshot doc = await chatCollection.doc(chatId).get();
    ChatEntity chatEntity = ChatEntity.fromJson(doc.data() as Map<String, dynamic>);
    return chatEntity;
  }


  // get chat members
  getChatMembers(chatId) async {
    return chatCollection.doc(chatId).snapshots();
  }

  // search
  searchById(String uid) {
    return chatCollection.where("chatName", isEqualTo: uid).get();
  }



  // function -> bool
  Future<bool> isUserJoined(
      String chatName, String chatId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> chats = await documentSnapshot['chats'];
    if (chats.contains("${chatId}_$chatName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future toggleChatJoin(
      String chatId, String userName, String chatName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference chatDocumentReference = chatCollection.doc(chatId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> chats = await documentSnapshot['chats'];

    // if user has our groups -> then remove then or also in other part re join
    if (chats.contains("${chatId}_$chatName")) {
      await userDocumentReference.update({
        "chats": FieldValue.arrayRemove(["${chatId}_$chatName"])
      });
      await chatDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "chats": FieldValue.arrayUnion(["${chatId}_$chatName"])
      });
      await chatDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String chatId, Map<String, dynamic> chatMessageData) async {
    chatCollection.doc(chatId).collection("messages").doc(chatMessageData['time'].toString()).set(chatMessageData);
    chatCollection.doc(chatId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

  Future sendUserFile(String chatId, File file, String path, Map<String, dynamic> chatMessageData) async {
    await FirebaseStorage.instance.ref().child(path).putFile(file);
    final message = await FirebaseStorage.instance.ref(path).getDownloadURL();
    chatMessageData["message"] = message;
    print('sending this message: $message');
    chatCollection.doc(chatId).collection("messages").add(chatMessageData);
    chatCollection.doc(chatId).update({
      "recentMessage": 'image',
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
  });
  }

  editMessage(String chatId, String message, String messageId) async {
    await chatCollection.doc(chatId).collection("messages").doc(messageId).update({'message': message, 'isEdited': true});
  }

  deleteMessage(String chatId, String messageId) async {
    await chatCollection.doc(chatId).collection("messages").doc(messageId).update({'isDeleted': true});
  }

  deleteChat(String chatId, String chatName) async {
    final doc = await chatCollection.doc(chatId).get();
    final data = doc.data() as Map<String, dynamic>;
    final members = data["members"];
    for (String member in members) {
      await userCollection.doc(member).update({'chats': FieldValue.arrayRemove(["${chatId}_$chatName"])});
    }
    await chatCollection.doc(chatId).delete();
  }

  // void writeNewPost(String uid, String username, String picture, String title,
  //     String body) async {
  //   // A post entry.
  //   final postData = {
  //     'author': username,
  //     'uid': uid,
  //     'body': body,
  //     'title': title,
  //     'starCount': 0,
  //     'authorPic': picture,
  //   };

  //   // Get a key for a new Post.
  //   final newPostKey =
  //       FirebaseDatabase.instance.ref().child('posts').push().key;
  //
  //   // Write the new post's data simultaneously in the posts list and the
  //   // user's post list.
  //   final Map<String, Map> updates = {};
  //   updates['/posts/$newPostKey'] = postData;
  //   updates['/user-posts/$uid/$newPostKey'] = postData;
  //
  //   return FirebaseDatabase.instance.ref().update(updates);
  // }
  //
  // deleteMessage(String chatId, ),
  //
  // //scroll down method
  // void scrollDown() =>
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (scrollController.hasClients) {
  //         scrollController.jumpTo(
  //             scrollController.position.maxScrollExtent);
  //       }
  //     });

  // Future<void> searchUser(String name) async {
  //   search =
  //   await FirebaseFirestoreService.searchUser(name);
  //   notifyListeners();
  // }

}
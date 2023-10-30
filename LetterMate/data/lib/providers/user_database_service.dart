// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:data/entity/chat/chat_entity.dart';
// import 'package:data/entity/chat_member/chat_member_entity.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// import '../entity/user/user_entity.dart';
//
// class UserDatabaseService {
//   final String uid;
//
//   UserDatabaseService({required this.uid});
//
//   final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   //init push notification
//   Future initPushNotification() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   // get fCMToken for current user
//   Future<String> getFCMToken() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     return fCMToken!;
//   }
//
//   Future<void> initNotifications() async {
//     final fCMToken = await getFCMToken();
//     print("Token: $fCMToken");
//     initPushNotification();
//   }
//
//   // update user data with given userEntity and update it's entities in chats
//   Future<void> updateUserData(UserEntity userEntity) async {
//     print('updating user in database service');
//     await userCollection.doc(userEntity.uid).set(userEntity.toJson());
//     if (userEntity.chats != [] && userEntity.chats != null) {
//       for (String chat in userEntity!.chats!) {
//         ChatEntity? chatEntity = await getChat(getId(chat));
//         // if (chatEntity!.recentMessageSender == userEntity.displayName) {
//         //   await chatCollection.doc(getId(chat)).update({'recentMessageSender': userEntity.displayName});
//         // }
//         await updateChatMember(
//             getId(chat),
//             ChatMemberEntity(
//                 uid: userEntity.uid,
//                 uuid: userEntity.uuid,
//                 name: userEntity.displayName,
//                 photoURL: userEntity.photoURL,
//                 fCMToken: userEntity.fCMToken,
//                 isTyping: 'false'));
//         await updateChatMessagesSender(getId(chat), uid, userEntity.displayName);
//       }
//     }
//   }
//
//   Future<void> updateUserName(String name) async {
//     print('updating name to this: $name');
//     await userCollection.doc(uid).update({'displayName': name});
//     final user = await getUserData();
//     await updateUserData(user);
//   }
//
//   Future<void> updateUserUUID(String uuid) async {
//     print('updating uuid to this: $uuid');
//     await userCollection.doc(uid).update({'uuid': uuid});
//     final user = await getUserData();
//     await updateUserData(user);
//   }
//
//   // update user photoURL, upload photo to firebase storage and set downloadURL to photoURL field
//   Future<void> updateUserPhoto(File file) async {
//     final path = '$uid/files/avatar/';
//     print('updating photo in database service');
//     await FirebaseStorage.instance.ref().child(path).putFile(file);
//     print('put photo in storage');
//     await userCollection.doc(uid).update({'photoURL': await FirebaseStorage.instance.ref(path).getDownloadURL()});
//     print('updated user photoURL');
//     final user = await getUserData();
//     print('updated photo and now update userdata');
//     return await updateUserData(user);
//   }
//
//   // get UserEntity for current user
//   Future<UserEntity> getUserData() async {
//     final DocumentSnapshot doc = await userCollection.doc(uid).get();
//     UserEntity user;
//
//     print('getting user data');
//     if (doc.data() == null) {
//       String photoURL = await FirebaseStorage.instance.ref('default_profile.jpg').getDownloadURL();
//       print(photoURL);
//       user = UserEntity(
//         uuid: uid,
//         uid: uid,
//         displayName: 'Anon',
//         photoURL: photoURL,
//         chats: [],
//         fCMToken: '',
//       );
//       user.copyWith(fCMToken: await getFCMToken());
//       await UserDatabaseService(uid: uid).updateUserData(user);
//     } else {
//       user = UserEntity.fromJson(doc.data() as Map<String, dynamic>);
//       user.copyWith(fCMToken: await getFCMToken());
//       await UserDatabaseService(uid: uid).updateUserData(user);
//     }
//     return user;
//   }
//
//   // getting a stream of userCollection
//   gettingUserData() async {
//     return userCollection.doc(uid).snapshots();
//   }
//
//   Future<UserEntity> getUserByUuid(String uuid) async {
//     final Query<Object?> query = userCollection.where(
//       'uuid',
//       isEqualTo: uuid,
//     );
//     final QuerySnapshot<Object?> data = await query.get();
//
//     return UserEntity.fromJson(data.docs.first.data() as Map<String, dynamic>);
//   }
//
//   // check if there is a doc in userCollection with given uuid
//   Future<bool> checkExist(String uuid) async {
//     try {
//       await userCollection.where("uuid", isEqualTo: uuid).get();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   deleteAccount() async {
//     UserEntity user = await getUserData();
//     if (user.chats != [] && user.chats != null) {
//       for (String chat in user!.chats!) {
//         List<dynamic> members = await getChatMembers(getId(chat));
//         if (members[0]['uid'] == user.uid) {
//           await deleteChat(getId(chat), members[1]['name'], members[0]['name']);
//         } else {
//           await deleteChat(getId(chat), members[0]['name'], members[1]['name']);
//         }
//       }
//     }
//     await userCollection.doc(uid).delete();
//     if (Platform.isAndroid) {
//       exit(0);
//       //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     } else if (Platform.isIOS) {
//       exit(0);
//     }
//   }
// }

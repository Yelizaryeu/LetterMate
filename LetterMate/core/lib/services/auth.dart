import 'dart:io';

import 'package:data/entity/user/user_entity.dart';
import 'package:data/providers/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anon
  Future signInAnon() async {
    try {
      print('1-st');
      UserCredential userCred = await _auth.signInAnonymously();
      print('2-nd');
      print('${userCred.user!.uid}');

      //await DatabaseService(uid: userCred.user!.uid).updateUserPhoto(File('assets/images/default_profile.jpg'), '${userCred.user!.uid}/files/avatar');
      UserEntity userEntity = await DatabaseService(uid: userCred.user!.uid).getUserData();
      return userEntity;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

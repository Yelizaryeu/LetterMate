import 'package:data/entity/user/user_entity.dart';
import 'package:data/providers/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCred = await _auth.signInAnonymously();
      UserEntity userEntity = await DatabaseService(uid: userCred.user!.uid).getUserData();
      return userEntity;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

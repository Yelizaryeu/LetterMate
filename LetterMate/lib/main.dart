import 'package:core/constants/api_constants.dart';
import 'package:core/di/app_di.dart';
import 'package:core/di/data_di.dart';
import 'package:core/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lettermate/app/letter_mate_app.dart';
import 'package:flutter/foundation.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options:
      const FirebaseOptions(
          apiKey: ApiConstants.apiKey,
          appId: ApiConstants.appId,
          messagingSenderId: ApiConstants.messagingSenderId,
          projectId: ApiConstants.projectId,
          storageBucket: ApiConstants.storageBucket,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
    // await Firebase.initializeApp(
    //   options:
    //       const FirebaseOptions(
    //           apiKey: "AIzaSyBQzKdJlhfGZZ2ssBwf8F5q0jj-M1Ohx70",
    //           appId: "1:701633595191:web:897e13c947fb3b4461fcb2",
    //           messagingSenderId: "701633595191",
    //           projectId: "lettermate-ed713"),
    // );
  await AuthService().signInAnon();
  print('init appDI start');
  await appDI.initDependencies();
  print('init dataDI start');
  await dataDI.initDependencies();
  print('running LetterMateApp');
  runApp(const LetterMateApp());
}

// class LetterMateApp extends StatelessWidget {
//
//   const LetterMateApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<ProfileBloc>(
//             create: (context) =>
//             serviceLocator<ProfileBloc>()..add(DatabaseFetchedEvent(serviceLocator.get<UserEntity>(instanceName: 'currentUser').displayName))),
//       ],
//       child: const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: ProfileViewScreen(),
//       ),
//     );
//   }
// }

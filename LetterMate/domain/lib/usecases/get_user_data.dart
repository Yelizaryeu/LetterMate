// import 'package:domain/usecases/usecase.dart';
// import '../models/user/user_model.dart';
// import '../repositories/database_repository.dart';
//
// class GetUserData extends UseCase<String, UserModel> {
//   final DatabaseRepository databaseRepository;
//
//   GetUserData(this.databaseRepository);
//
//   // @override
//   // Future<UserModel> call(String params) async {
//   //   return await databaseRepository.getUserData(params);
//   //
//   //  // UserModel userModel = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserData(FirebaseAuth.instance.currentUser!.uid);
//   //  // return userModel;
//   // }
//
//   @override
//   Future<UserModel> execute() async {
//     return await databaseRepository.getUserData();
//   }
// }
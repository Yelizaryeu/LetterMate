import 'package:chat_view/chat_view.dart';
import 'package:data/providers/database_service.dart';
import 'package:data/repositories/database_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecases/update_avatar_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profile_view/profile_view.dart';

import 'app_di.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> initDependencies() async {
    await _initApi();
    await _initChats();
  }

  Future _initApi() async {
    // appLocator.registerLazySingleton<ErrorHandler>(
    //   ErrorHandler.new,
    // );
    // final currentUser = await AuthService().signInAnon();
    // print('signed current user');
    // appLocator.registerSingleton<UserEntity>(currentUser, instanceName: 'currentUser',);

    appLocator.registerLazySingleton<DatabaseService>(
      () => DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid),
    );

    await appLocator<DatabaseService>().initNotifications();
  }

  Future _initChats() async {
    appLocator.registerLazySingleton<DatabaseRepository>(
      () => DatabaseRepositoryImpl(
        databaseService: appLocator.get<DatabaseService>(),
      ),
    );

    //Profile BLoC
    appLocator.registerFactory(
      () => ProfileBloc(
        updateUserData: appLocator(),
        updateUserAvatar: appLocator(),
        getUserData: appLocator(),
        deleteUserUseCase: appLocator(),
      ),
    );

    //Chat BLoC
    appLocator.registerFactory(
      () => ChatBloc(
        databaseRepository: appLocator(),
      ),
    );

    appLocator.registerLazySingleton<UpdateUserData>(
      () => UpdateUserData(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<UpdateUserAvatar>(
      () => UpdateUserAvatar(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<DeleteUserUseCase>(
      () => DeleteUserUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GetUserData>(
      () => GetUserData(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );
  }
}

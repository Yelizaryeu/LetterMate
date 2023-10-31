import 'package:core/di/app_di.dart';
import 'package:data/providers/database_service.dart';
import 'package:data/repositories/database_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecases/update_avatar_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    appLocator.registerLazySingleton<UpdateUserDataUseCase>(
      () => UpdateUserDataUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<UpdateUserAvatarUseCase>(
      () => UpdateUserAvatarUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<DeleteUserUseCase>(
      () => DeleteUserUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );
  }
}

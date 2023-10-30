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
    appLocator.registerLazySingleton<DatabaseService>(
      () => DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid ?? ''),
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

    appLocator.registerLazySingleton<GettingChatMessagesUseCase>(
      () => GettingChatMessagesUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GettingChatMembersUseCase>(
      () => GettingChatMembersUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GettingUserDataUseCase>(
      () => GettingUserDataUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<CreateChatUseCase>(
      () => CreateChatUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<CheckUserExistenceUseCase>(
      () => CheckUserExistenceUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<DeleteMessageUseCase>(
      () => DeleteMessageUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<EditMessageUseCase>(
      () => EditMessageUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<DeleteChatUseCase>(
      () => DeleteChatUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<TypingMessageUseCase>(
      () => TypingMessageUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SendFileUseCase>(
      () => SendFileUseCase(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );
  }
}

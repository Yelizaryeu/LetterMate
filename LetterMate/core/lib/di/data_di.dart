import 'package:data/entity/user/user_entity.dart';
import 'package:data/errors/error_handler.dart';
import 'package:data/providers/database_service.dart';
import 'package:data/repositories/database_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/usecases/export_usecases.dart';
import 'package:profile_view/profile_view.dart';
import 'package:chat_view/chat_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth.dart';
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
      () => DatabaseService(),
    );
  }

  Future _initChats() async {
    appLocator.registerLazySingleton<DatabaseRepository>(
      () => DatabaseRepositoryImpl(
        databaseService: appLocator.get<DatabaseService>(),
      ),
    );

    //Profile BLoC
     appLocator.registerFactory(
           () => ProfileBloc(databaseRepository: appLocator(),),
     );

     //Chat BLoC
    appLocator.registerFactory(
          () => ChatBloc(databaseRepository: appLocator(),),
    );

    appLocator.registerLazySingleton<UpdateCurrentUser>(
      () => UpdateCurrentUser(
        databaseRepository: appLocator.get<DatabaseRepository>(),
      ),
    );
    //
    // appLocator.registerLazySingleton<FetchSearchAlbumsUseCase>(
    //   () => FetchSearchAlbumsUseCase(
    //     albumsRepository: appLocator.get<AlbumsRepository>(),
    //   ),
    // );
    //
    // appLocator.registerLazySingleton<FetchAlbumPicturesUseCase>(
    //   () => FetchAlbumPicturesUseCase(
    //     albumsRepository: appLocator.get<AlbumsRepository>(),
    //   ),
    // );
  }
}

import 'package:data/entity/user/user_entity.dart';
import 'package:data/providers/database_service.dart';
import 'package:data/repositories/database_repository_impl.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:get_it/get_it.dart';

import '../services/auth.dart';


final serviceLocator = GetIt.instance;

Future<void> init() async {


  // CurrentUser
  //serviceLocator.registerSingleton<UserEntity>(await AuthService().signInAnon(), instanceName: 'currentUser',);


  // BLoC
  //  serviceLocator.registerFactory(
  //        () => DatabaseBloc(databaseRepository: serviceLocator(),),
  //  );

   // Repository
  serviceLocator.registerLazySingleton<DatabaseRepository>(
        () => DatabaseRepositoryImpl(
      databaseService: serviceLocator(),
    ),
  );

  // DatabaseService
  serviceLocator.registerLazySingleton<DatabaseService>(
      () => DatabaseService(
        uid: serviceLocator(),
      ),
  );

  // UseCases
  //serviceLocator.registerLazySingleton(() => GetAllChats(serviceLocator()));

  // UserModel
  // serviceLocator
  //     .registerFactoryParam<UserModel,Map<String, dynamic>, String>
  //   ((json, uid) => UserModel.fromJson(json ,uid));

  // Core
  // serviceLocator.registerLazySingleton<NetworkInfo>(
  //       () => NetworkInfoImp(serviceLocator()),
  // );

   // External
   // final sharedPreferences = await SharedPreferences.getInstance();
   // serviceLocator.registerLazySingleton(() => sharedPreferences);
   // serviceLocator.registerLazySingleton(() => http.Client());
   // serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
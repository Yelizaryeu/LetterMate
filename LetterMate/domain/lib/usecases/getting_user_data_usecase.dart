import 'package:domain/usecases/usecase.dart';

import '../models/user/user_model.dart';
import '../repositories/database_repository.dart';

class GettingUserDataUseCase extends StreamUseCase<NoParams, UserModel> {
  final DatabaseRepository _databaseRepository;

  GettingUserDataUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Stream<UserModel> execute(NoParams input) {
    return _databaseRepository.gettingUserData();
  }
}

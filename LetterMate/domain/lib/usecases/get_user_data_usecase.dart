import 'package:domain/usecases/usecase.dart';

import '../models/user/user_model.dart';
import '../repositories/database_repository.dart';

class GetUserDataUseCase extends FutureUseCase<NoParams, UserModel> {
  final DatabaseRepository _databaseRepository;

  GetUserDataUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Future<UserModel> execute(NoParams input) async {
    return _databaseRepository.getUserData();
  }
}

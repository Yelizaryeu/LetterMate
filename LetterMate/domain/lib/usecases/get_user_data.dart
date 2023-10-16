import 'package:domain/usecases/usecase.dart';

import '../models/user/user_model.dart';
import '../repositories/database_repository.dart';

class GetUserData extends FutureUseCase<NoParams, UserModel> {
  final DatabaseRepository _databaseRepository;

  GetUserData({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Future<UserModel> execute(NoParams input) async {
    return await _databaseRepository.getUserData();
  }
}

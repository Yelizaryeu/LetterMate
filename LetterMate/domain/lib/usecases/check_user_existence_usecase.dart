import 'package:domain/usecases/usecase.dart';

import '../repositories/database_repository.dart';

class CheckUserExistenceUseCase extends FutureUseCase<String, bool> {
  final DatabaseRepository _databaseRepository;

  CheckUserExistenceUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Future<bool> execute(String input) async {
    return _databaseRepository.checkUserExistence(input);
  }
}

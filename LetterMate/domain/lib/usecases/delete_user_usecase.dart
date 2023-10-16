import 'package:domain/usecases/usecase.dart';

import '../repositories/database_repository.dart';

class DeleteUserUseCase extends FutureUseCase<NoParams, void> {
  final DatabaseRepository _databaseRepository;

  DeleteUserUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Future<void> execute(NoParams input) async {
    return await _databaseRepository.deleteUserAccount();
  }
}

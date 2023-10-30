import 'package:domain/usecases/usecase.dart';

import '../repositories/database_repository.dart';

class CreateChatUseCase extends FutureUseCase<String, void> {
  final DatabaseRepository _databaseRepository;

  CreateChatUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Future<void> execute(String input) async {
    return _databaseRepository.createChat(input);
  }
}

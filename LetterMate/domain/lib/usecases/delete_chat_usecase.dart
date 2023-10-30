import 'package:domain/usecases/usecase.dart';

import '../repositories/database_repository.dart';

class DeleteChatUseCase extends FutureUseCase<String, void> {
  final DatabaseRepository _databaseRepository;

  DeleteChatUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Future<void> execute(String input) async {
    return _databaseRepository.deleteChat(input);
  }
}

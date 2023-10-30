import 'package:domain/usecases/usecase.dart';

import '../models/message/message_model.dart';
import '../repositories/database_repository.dart';

class GettingChatMessagesUseCase extends StreamUseCase<String, List<MessageModel>?> {
  final DatabaseRepository _databaseRepository;

  GettingChatMessagesUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Stream<List<MessageModel>?>? execute(String input) {
    return _databaseRepository.gettingChatMessages(input);
  }
}

import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';

class DeleteMessageUseCase extends FutureUseCase<MessageModel, void> {
  final DatabaseRepository _databaseRepository;

  DeleteMessageUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Future<void> execute(MessageModel input) async {
    return _databaseRepository.deleteMessage(input);
  }
}

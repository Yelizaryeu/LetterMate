import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';

class EditMessageUseCase extends FutureUseCase<MessageModel, void> {
  final DatabaseRepository _databaseRepository;

  EditMessageUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Future<void> execute(MessageModel input) async {
    return _databaseRepository.editMessage(input);
  }
}

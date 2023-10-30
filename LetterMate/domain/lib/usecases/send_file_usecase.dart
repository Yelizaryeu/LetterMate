import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';

class SendFileUseCase extends FutureUseCase<MessageModel, void> {
  final DatabaseRepository databaseRepository;

  SendFileUseCase({required this.databaseRepository});

  @override
  Future<void> execute(MessageModel input) async {
    await databaseRepository.sendFileMessage(input);
  }
}

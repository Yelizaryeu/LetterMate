import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';

class SendMessageUseCase extends FutureUseCase<MessageModel, void> {
  final DatabaseRepository databaseRepository;

  SendMessageUseCase({required this.databaseRepository});

  @override
  Future<void> execute(MessageModel input) async {
    print('calling sendMessage from repository');
    await databaseRepository.sendMessage(input);
  }
}

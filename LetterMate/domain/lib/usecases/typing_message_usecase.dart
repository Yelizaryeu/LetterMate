import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';

class TypingMessageUseCase extends FutureUseCase<ChatMemberModel, void> {
  final DatabaseRepository databaseRepository;

  TypingMessageUseCase({required this.databaseRepository});

  @override
  Future<void> execute(ChatMemberModel input) async {
    await databaseRepository.updateChatMember(input);
  }
}

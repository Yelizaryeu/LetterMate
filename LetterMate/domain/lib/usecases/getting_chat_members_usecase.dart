import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';

class GettingChatMembersUseCase extends StreamUseCase<String, List<ChatMemberModel>?> {
  final DatabaseRepository _databaseRepository;

  GettingChatMembersUseCase({
    required DatabaseRepository databaseRepository,
  }) : _databaseRepository = databaseRepository;

  @override
  Stream<List<ChatMemberModel>?>? execute(String input) {
    return _databaseRepository.gettingChatMembers(input);
  }
}

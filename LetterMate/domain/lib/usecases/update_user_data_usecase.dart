import 'package:domain/usecases/usecase.dart';

import '../models/user/user_model.dart';
import '../repositories/database_repository.dart';

class UpdateUserDataUseCase extends FutureUseCase<UserModel, void> {
  final DatabaseRepository databaseRepository;

  UpdateUserDataUseCase({required this.databaseRepository});

  @override
  Future<void> execute(UserModel input) async {
    await databaseRepository.updateUserName(input.displayName);
    await databaseRepository.updateUserUUID(input.uuid);
  }
}

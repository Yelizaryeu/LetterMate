


import 'package:domain/usecases/usecase.dart';
import '../models/user/user_model.dart';
import 'package:data/entity/user/user_entity.dart';
import '../repositories/database_repository.dart';

class UpdateCurrentUser extends UseCase<UserEntity, void> {
  final DatabaseRepository databaseRepository;

  UpdateCurrentUser({required this.databaseRepository});

  @override
  Future<void> execute(UserEntity input) async {
    await databaseRepository.updateUserData(input);
  }
}
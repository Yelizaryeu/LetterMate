import 'dart:io';

import 'package:domain/usecases/usecase.dart';

import '../repositories/database_repository.dart';

class UpdateUserAvatar extends FutureUseCase<File, void> {
  final DatabaseRepository databaseRepository;

  UpdateUserAvatar({required this.databaseRepository});

  @override
  Future<void> execute(File input) async {
    await databaseRepository.updateUserAvatar(input);
  }
}

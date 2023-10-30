import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:domain/usecases/export_usecases.dart';
import 'package:domain/usecases/update_avatar_usecase.dart';
import 'package:flutter/material.dart';

import '../../profile_view.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
        create: (BuildContext context) => ProfileBloc(
              updateUserAvatarUseCase: appLocator<UpdateUserAvatarUseCase>(),
              updateUserDataUseCase: appLocator<UpdateUserDataUseCase>(),
              deleteUserUseCase: appLocator<DeleteUserUseCase>(),
              getUserDataUseCase: appLocator<GetUserDataUseCase>(),
            )..add(ProfileInitEvent()),
        child: const ProfileViewForm());
  }
}

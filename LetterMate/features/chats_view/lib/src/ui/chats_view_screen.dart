import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:domain/usecases/export_usecases.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import 'chats_view_form.dart';

class ChatsViewScreen extends StatelessWidget {
  const ChatsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatsBloc>(
        create: (BuildContext context) => ChatsBloc(
              updateUserDataUseCase: appLocator<UpdateUserDataUseCase>(),
              gettingUserDataUseCase: appLocator<GettingUserDataUseCase>(),
              createChatUseCase: appLocator<CreateChatUseCase>(),
              checkUserExistenceUseCase: appLocator<CheckUserExistenceUseCase>(),
            ),
        child: const ChatsViewForm());
  }
}

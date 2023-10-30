import 'package:core_ui/core_ui.dart';
import 'package:domain/models/user/user_model.dart';
import 'package:flutter/material.dart';

import 'no_chats_widget.dart';

class ChatListWidget extends StatelessWidget {
  final UserModel userModel;

  const ChatListWidget({
    required this.userModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userModel.chats != null) {
      if (userModel.chats != []) {
        if (userModel.chats!.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: AppDimens.PADDING_5),
            itemCount: userModel.chats!.length,
            itemBuilder: (context, index) {
              int reverseIndex = userModel.chats!.length - index - 1;

              return ChatTile(
                  chatId: userModel.chats![reverseIndex].substring(
                    0,
                    userModel.chats![reverseIndex].indexOf("_"),
                  ),
                  chatName: userModel.chats![reverseIndex].substring(userModel.chats![reverseIndex].indexOf("_") + 1),
                  userName: userModel.displayName);
            },
          );
        } else {
          return const NoChatsWidget();
        }
      } else {
        return const NoChatsWidget();
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

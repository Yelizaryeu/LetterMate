import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../chat_view.dart';

class ChatTypingIndicatorWidget extends StatelessWidget {
  final ChatState state;
  const ChatTypingIndicatorWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.isCompanionTyping) {
      if (state.members![0].name != state.userName) {
        return SimpleTypingIndicatorWidget(
          user: state.members![0].name,
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}

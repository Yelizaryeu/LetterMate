import 'package:chats_view/src/ui/widgets/chat_list_widget.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';

class ChatsViewForm extends StatefulWidget {
  const ChatsViewForm({super.key});

  @override
  State<ChatsViewForm> createState() => _ChatsFormState();
}

class _ChatsFormState extends State<ChatsViewForm> {
  final TextEditingController _uuidController = TextEditingController();

  @override
  void dispose() {
    _uuidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextWidget) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (BuildContext context, ChatsState state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.grey,
            title: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: AppDimens.PADDING_1),
                    child: Text(
                      'New chat',
                      textAlign: TextAlign.right,
                      style: AppFonts.normal20black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: AppDimens.PADDING_1),
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_40),
                          ),
                        ),
                      ),
                      onPressed: () {
                        popUpDialog(context);
                      },
                      child: const Icon(
                        Icons.add_circle,
                        color: AppColors.blue,
                        size: AppDimens.BORDER_RADIUS_23,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: state.userModel != null
              ? ChatListWidget(userModel: state.userModel!)
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
        );
      },
    );
  }

  popUpDialog(BuildContext contextWidget) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a chat",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    controller: _uuidController,
                    hintText: 'Enter UUID',
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<ChatsBloc>(contextWidget).add(ChatsCreateEvent(_uuidController.text));
                    Navigator.of(contextWidget).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(contextWidget).primaryColor),
                  child: const Text("CREATE"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showSnackBar(contextWidget, color, message) {
    ScaffoldMessenger.of(contextWidget).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 14),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
          textColor: Colors.white,
        ),
      ),
    );
  }
}

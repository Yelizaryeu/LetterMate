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
                      style: AppFonts.normal20.copyWith(
                        color: AppColors.black,
                      ),
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
                        showCreateChatMenu(context);
                        //popUpDialog(context);
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

  void showCreateChatMenu(BuildContext contextWidget) {
    showModalBottomSheet(
      backgroundColor: AppColors.lightBlue,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimens.BORDER_RADIUS_10),
          topRight: Radius.circular(AppDimens.BORDER_RADIUS_10),
        ),
      ),
      builder: (_) {
        return SizedBox(
          height: AppDimens.heightNewChat,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: AppDimens.PADDING_18),
                    child: Text(
                      'New chat',
                      style: AppFonts.normal20.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.cancel_rounded,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    AppTextField(
                      controller: _uuidController,
                      hintText: 'User UUID',
                      color: AppColors.grey,
                      width: 340,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppDimens.PADDING_30),
                      child: ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<ChatsBloc>(contextWidget).add(ChatsCreateEvent(_uuidController.text));
                          Navigator.of(contextWidget).pop();
                          _uuidController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: AppFonts.robotoBold16.copyWith(
                            color: AppColors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_8),
                          ),
                          backgroundColor: AppColors.blue,
                        ),
                        child: const Text('Create'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

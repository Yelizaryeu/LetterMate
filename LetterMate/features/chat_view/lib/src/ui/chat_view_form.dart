import 'package:chat_view/src/ui/widgets/typing_indicator.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/message/message_model.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';

class ChatViewForm extends StatefulWidget {
  const ChatViewForm({super.key});

  @override
  State<ChatViewForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatViewForm> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextWidget) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (BuildContext context, ChatState state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state.chatName),
                PopupMenuButton(
                  offset: const Offset(
                    AppDimens.OFFSET_0,
                    AppDimens.OFFSET_50,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.more_horiz_rounded,
                      color: AppColors.darkerGrey,
                      size: AppDimens.BORDER_RADIUS_23,
                    ),
                  ),
                  itemBuilder: (BuildContext contextWidget) {
                    return <PopupMenuItem>[
                      PopupMenuItem(
                        height: AppDimens.popUpMenuHeight,
                        child: const Text('Delete chat'),
                        onTap: () {
                          BlocProvider.of<ChatBloc>(contextWidget).add(DeleteChatEvent(state.chatId));
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ];
                  },
                ),
              ],
            ),
            backgroundColor: AppColors.grey,
          ),
          body: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              // chat messages here

              state.messages != null
                  ? chatMessages(state)
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.PADDING_6, vertical: AppDimens.PADDING_25),
                child: ChatTypingIndicatorWidget(state: state),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: AppDimens.PADDING_5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.PADDING_20, vertical: AppDimens.PADDING_18),
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.grey,
                  child: Row(children: [
                    GestureDetector(
                      onTap: () async {
                        BlocProvider.of<ChatBloc>(contextWidget).add(FileSelectEvent());
                      },
                      child: const SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                            child: Icon(
                          Icons.add_circle_rounded,
                          color: Colors.black54,
                          size: 40.0,
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: AppDimens.PADDING_14, bottom: AppDimens.PADDING_8, top: AppDimens.PADDING_8),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.black54),
                            borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
                          ),
                          filled: true,
                          fillColor: AppColors.black12,
                          hintText: "Message",
                          hintStyle: const TextStyle(color: Colors.black26, fontSize: 16),
                          border: InputBorder.none,
                        ),
                        // onTap: () {
                        //   BlocProvider.of<ChatBloc>(contextWidget).add(TypingMessageEvent());
                        // },
                        onChanged: (text) async {
                          if (text != '' && state.isEditMode == false && state.isTyping == false) {
                            BlocProvider.of<ChatBloc>(contextWidget).add(TypingMessageEvent());
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        state.isEditMode ? updateMessage(contextWidget, state) : sendMessage(contextWidget, state);
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: state.isEditMode
                              ? const Icon(
                                  Icons.check_circle,
                                  color: AppColors.white,
                                )
                              : const Icon(
                                  Icons.send_rounded,
                                  color: AppColors.black54,
                                  size: 40.0,
                                ),
                        ),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  chatMessages(ChatState state) {
    if (state.messages != []) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(_scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        }
      });
    }
    return state.messages != null
        ? ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: AppDimens.PADDING_5, bottom: AppDimens.PADDING_105),
            itemCount: state.messages!.length,
            itemBuilder: (context, index) {
              return PopupMenuButton(
                offset: const Offset(
                  AppDimens.OFFSET_0,
                  AppDimens.OFFSET_50,
                ),
                child: MessageTile(
                  message: state.messages![index].message,
                  senderName: state.messages![index].senderName,
                  time: state.messages![index].time,
                  sentByMe: state.userName == state.messages![index].senderName,
                  messageType: state.messages![index].messageType,
                  isEdited: state.messages![index].isEdited,
                  isDeleted: state.messages![index].isDeleted,
                ),
                itemBuilder: (BuildContext contextWidget) {
                  return <PopupMenuItem>[
                    PopupMenuItem(
                      height: AppDimens.popUpMenuHeight,
                      child: const Text('Edit'),
                      onTap: () {
                        BlocProvider.of<ChatBloc>(contextWidget)
                            .add(EditModeEvent(state.messages![index].time.toString()));
                        _messageController.text = state.messages![index].message;
                      },
                    ),
                    PopupMenuItem(
                      height: AppDimens.popUpMenuHeight,
                      child: const Text('Delete'),
                      onTap: () {
                        BlocProvider.of<ChatBloc>(contextWidget).add(DeleteMessageEvent(state.messages![index]));
                      },
                    ),
                  ];
                },
              );
            },
          )
        : const Center(
            child: Text('messages is null'),
          );
  }

  sendMessage(BuildContext contextWidget, ChatState state) {
    if (_messageController.text.isNotEmpty) {
      MessageModel message = MessageModel(
          senderId: '',
          senderName: state.userName,
          message: _messageController.text,
          chatId: state.chatId,
          time: DateTime.now().millisecondsSinceEpoch,
          messageType: 'text',
          isEdited: false,
          isDeleted: false);

      BlocProvider.of<ChatBloc>(contextWidget).add(SendMessageEvent(message));
      _messageController.clear();
    }
  }

  updateMessage(BuildContext contextWidget, ChatState state) async {
    MessageModel message = MessageModel(
        senderId: '',
        senderName: state.userName,
        message: _messageController.text,
        chatId: state.chatId,
        time: int.parse(state.editId),
        messageType: 'text',
        isEdited: false,
        isDeleted: false);
    BlocProvider.of<ChatBloc>(contextWidget).add(EditMessageEvent(message));
    _messageController.clear();
  }
}

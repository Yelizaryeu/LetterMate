import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class ChatTile extends StatefulWidget {
  final String userName;
  final String chatId;
  final String chatName;
  String? resentMessage;
  String? resentMessageSender;

  ChatTile(
      {Key? key,
        this.resentMessageSender,
        this.resentMessage,
        required this.chatId,
        required this.chatName,
        required this.userName,
      })
      : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  String? resentMessageSender;
  String? resentMessage;

  _ChatTileState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(
          ChatViewRoute(chatId: widget.chatId, chatName: widget.chatName, userName: widget.userName),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.chatName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          tileColor: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0),),),
          title: Text(
            widget.resentMessageSender ?? widget.chatName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            widget.resentMessage ?? "Join the conversation as ${widget.userName}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
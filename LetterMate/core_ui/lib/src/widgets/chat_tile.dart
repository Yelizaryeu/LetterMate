import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class ChatTile extends StatefulWidget {
  String userName;
  final String chatId;
  String chatName;
  String? recentMessage;
  int? recentMessageTime;
  String? recentMessageSender;

  ChatTile({
    Key? key,
    this.recentMessageSender,
    this.recentMessage,
    this.recentMessageTime,
    required this.chatId,
    required this.chatName,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  String? recentMessageSender;
  String? recentMessage;
  DatabaseService databaseService = appLocator<DatabaseService>();

  _ChatTileState();

  @override
  void initState() {
    getRecentMessage(widget.chatId);
    getChatName(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    getRecentMessage(widget.chatId);
    getChatName(widget.chatId);
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
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          tileColor: AppColors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.BORDER_RADIUS_5),
            ),
          ),
          title: Text(
            widget.chatName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: formatResentMessage(widget.recentMessage, widget.recentMessageTime, widget.recentMessageSender),
        ),
      ),
    );
  }

  getRecentMessage(String chatId) async {
    ChatEntity? chatEntity = await databaseService.getChat(chatId);
    if (chatEntity != null) {
      setState(() {
        widget.recentMessage = chatEntity.recentMessage;
        widget.recentMessageTime = chatEntity.recentMessageTime;
        widget.recentMessageSender = chatEntity.recentMessageSender;
      });
    }
  }

  getChatName(String chatId) async {
    List<ChatMemberEntity> members = await databaseService.getChatMembers(chatId);
    if (members[0].name == widget.userName) {
      setState(() {
        widget.chatName = members[1].name;
      });
    } else {
      setState(() {
        widget.chatName = members[0].name;
      });
    }
  }

  Widget formatResentMessage(String? message, int? time, String? messageSender) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          messageSender == widget.userName ? message ?? "Joined as ${widget.userName}" : '$messageSender: $message',
          style: const TextStyle(fontSize: 13),
        ),
        Text(
          time != null ? messageDate(time) : '',
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  String messageDate(int time) {
    final messageSendTime = DateTime.fromMillisecondsSinceEpoch(time);
    if ((DateTime.now().millisecondsSinceEpoch - time) < 20000) {
      return "now";
    } else if ((DateTime.now().millisecondsSinceEpoch - time) < 86400000) {
      return "${messageSendTime.hour}:${messageSendTime.minute}";
    } else {
      return "${messageSendTime.day}/${messageSendTime.month}/${messageSendTime.year}";
    }
  }
}

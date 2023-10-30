import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String senderName;
  final int time;
  final bool sentByMe;
  final String messageType;
  final bool isEdited;
  final bool isDeleted;
  final String? fileName;

  const MessageTile({
    Key? key,
    required this.message,
    required this.senderName,
    required this.time,
    required this.sentByMe,
    required this.messageType,
    required this.isEdited,
    required this.isDeleted,
    this.fileName,
  }) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: widget.sentByMe ? 0 : 24, right: widget.sentByMe ? 24 : 0),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe ? const EdgeInsets.only(left: 30) : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: widget.sentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
            color: widget.sentByMe ? Colors.grey.shade400 : Colors.grey.shade400),
        child: widget.isDeleted
            ? const Text(
                'deleted',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, color: Colors.black54, fontStyle: FontStyle.italic),
              )
            : getMessage(widget.messageType),
      ),
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

  Widget getMessage(String messageType) {
    if (messageType == 'image') {
      return Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.message),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (messageType == 'file') {
      return Container(
        height: 100,
        width: 100,
        child: Text(
          widget.fileName!,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    } else if (messageType == 'text') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.senderName,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: -0.5),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                (widget.isEdited ? "Edited " : "") + messageDate(widget.time),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black, letterSpacing: -0.5),
              ),
            ],
          ),
          Text(
            widget.message,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:data/providers/database_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';


class ChatViewScreen extends StatefulWidget {
  final String chatId;
  final String chatName;
  final String userName;
  const ChatViewScreen(
      {Key? key,
        required this.chatId,
        required this.chatName,
        required this.userName,
      })
      : super(key: key);

  @override
  State<ChatViewScreen> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatViewScreen> {
  Stream<QuerySnapshot>? chats;
  bool editMode = false;
  String messageId = '';
  PlatformFile? pickedFile;
  PlatformFile? pickedImage;
  Offset _tapPosition = Offset.zero;
  DatabaseService databaseService = appLocator<DatabaseService>();

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    getChat();
    super.initState();
  }

  getChat() {
    DatabaseService().getChats(widget.chatId).then((val) {
      setState(() {
        chats = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.chatName),
            GestureDetector(
              onTapDown: (position) => {_getTapPosition(position)},
              onLongPress: () => {_showDeleteChatMenu(context, widget.chatId, widget.chatName)},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.grey.shade800,
                    size: 25.0,
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.grey.shade400,
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          const SizedBox(
            width: 12,
            height: 50,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade400,
              child: Row(children: [
                GestureDetector(
                  onTap: () async {
                    await selectImage();
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    // decoration: BoxDecoration(
                    //   color: Theme.of(context).primaryColor,
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    child: const Center(
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
                GestureDetector(
                  onTap: () async {
                    await selectFile();
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    // decoration: BoxDecoration(
                    //   color: Theme.of(context).primaryColor,
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    child: const Center(
                        child: Icon(
                          Icons.file_present,
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
                      controller: messageController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Message",
                        hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    editMode
                    ? updateMessage()
                    : sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    // decoration: BoxDecoration(
                    //   color: Theme.of(context).primaryColor,
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    child: Center(
                        child: editMode
                            ? const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                            : const Icon(
                          Icons.send_rounded,
                          color: Colors.black54,
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
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTapDown: (position) => {_getTapPosition(position)},
              onLongPress: () => {_showMessageMenu(context, snapshot.data.docs[index]['message'], snapshot.data.docs[index]['time'].toString(),)},

              onTap: () async {
                if (editMode == false) {
                  //messageId = snapshot.data[index]['time'];
                  setState(() {
                    editMode = true;
                  });
                } else {
                  // messageId = '';
                  setState(() {
                    editMode = false;
                  });
                }

                messageId = snapshot.data.docs[index]['time'].toString();

                editMessage(snapshot.data.docs[index]['message']);
              },
              child: MessageTile(
                message: snapshot.data.docs[index]['message'],
                sender: snapshot.data.docs[index]['sender'],
                time: snapshot.data.docs[index]['time'],
                sentByMe: widget.userName ==
                    snapshot.data.docs[index]['sender'],
                messageType: snapshot.data.docs[index]['messageType'],
                isEdited: snapshot.data.docs[index]['isEdited'],
                isDeleted: snapshot.data.docs[index]['isDeleted'],
              ),
            );
          },
        )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
        "messageType": "text",
        "isEdited": false,
        "isDeleted": false,
      };
      databaseService.sendMessage(widget.chatId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
    if (pickedImage != null) {
      Map<String, dynamic> chatMessageMap = {
        "message": '',
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
        "messageType": "image",
        "isEdited": false,
      };

      databaseService.sendUserFile(widget.chatId, File(pickedImage!.path!), '${widget.chatId}/files/${DateTime.now().millisecondsSinceEpoch}', chatMessageMap);
      setState(() {
        pickedImage = null;
      });

    }

    if (pickedFile != null) {
      Map<String, dynamic> chatMessageMap = {
        "message": '',
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
        "messageType": "file",
        "isEdited": false,
      };

      databaseService.sendUserFile(widget.chatId, File(pickedFile!.path!), '${widget.chatId}/files/${DateTime.now().millisecondsSinceEpoch}', chatMessageMap);
      setState(() {
        pickedFile = null;
      });

    }

  }

  editMessage(String originalMessage) {
    messageController.text = originalMessage;
  }

  updateMessage() async {
    await databaseService.editMessage(widget.chatId, messageController.text, messageId);
    setState(() {
      editMode = false;
      messageId = '';
      messageController.clear();
    });
  }

  deleteMessage(mesId) async {
    await databaseService.deleteMessage(widget.chatId, mesId);
    setState(() {
      messageId = '';
    });
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    setState(() {
      pickedImage = result.files.first;
      print(pickedImage!.path);
    });
    // final imagePicker = ImagePicker();
    // final file = await imagePicker.pickImage(
    //     source: ImageSource.gallery);
    // if (file != null) {
    //   print('returned this: ${file.path}');
    //   return await file.readAsBytes();
    // }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      print(pickedFile!.path);
    });
    // final imagePicker = ImagePicker();
    // final file = await imagePicker.pickImage(
    //     source: ImageSource.gallery);
    // if (file != null) {
    //   print('returned this: ${file.path}');
    //   return await file.readAsBytes();
    // }
  }

  deleteChat(chatId, chatName) async {
    await databaseService.deleteChat(chatId, chatName);
  }

  void _getTapPosition(TapDownDetails tapPosition){
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(tapPosition.globalPosition);   // store the tap positon in offset variable
      print(_tapPosition);
    });
  }

  void _showMessageMenu(BuildContext context, String message, String mesId) async {
    final RenderObject? overlay =
    Overlay.of(context)?.context.findRenderObject();

    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay!.paintBounds.size.height)),
        items: [
          const PopupMenuItem(
            child: Text('Edit'),
            value: "edit",
          ),
          const PopupMenuItem(
            child: Text('Delete'),
            value: "delete",
          )
        ]);
    // perform action on selected menu item
    switch (result) {
      case 'edit':
        if (editMode == false) {
          //messageId = snapshot.data[index]['time'];
          setState(() {
            editMode = true;
          });
        } else {
          // messageId = '';
          setState(() {
            editMode = false;
          });
        }
        messageId = mesId;
        editMessage(message);
        break;
      case 'delete':
        print('delete');
        messageId = mesId;
        deleteMessage(messageId);
        break;
    }
  }

  void _showDeleteChatMenu(BuildContext context, String chatId, String chatName) async {
    final RenderObject? overlay =
    Overlay.of(context)?.context.findRenderObject();

    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay!.paintBounds.size.height)),
        items: [
          const PopupMenuItem(
            child: Text('Delete chat'),
            value: "delete",
          ),
        ]);
    // perform action on selected menu item
    switch (result) {
      case 'delete':
        deleteChat(chatId, chatName);
        Navigator.pop(context);
        break;
    }
  }

}

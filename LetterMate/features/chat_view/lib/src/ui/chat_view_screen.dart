import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:domain/usecases/export_usecases.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import 'chat_view_form.dart';

class ChatViewScreen extends StatelessWidget {
  final String chatId;

  const ChatViewScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
        create: (BuildContext context) => ChatBloc(
              gettingChatMessagesUseCase: appLocator<GettingChatMessagesUseCase>(),
              gettingChatMembersUseCase: appLocator<GettingChatMembersUseCase>(),
              getUserDataUseCase: appLocator<GetUserDataUseCase>(),
              sendMessageUseCase: appLocator<SendMessageUseCase>(),
              sendFileUseCase: appLocator<SendFileUseCase>(),
              deleteMessageUseCase: appLocator<DeleteMessageUseCase>(),
              deleteChatUseCase: appLocator<DeleteChatUseCase>(),
              editMessageUseCase: appLocator<EditMessageUseCase>(),
              typingMessageUseCase: appLocator<TypingMessageUseCase>(),
              chatId: chatId,
            ),
        child: const ChatViewForm());
  }
}

// import 'package:core/core.dart';
// import 'package:core/di/app_di.dart';
// import 'package:domain/usecases/export_usecases.dart';
// import 'package:flutter/material.dart';
//
// import '../bloc/bloc.dart';
// import 'chat_view_form.dart';
//
// class ChatViewScreen extends StatelessWidget {
//   const ChatViewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ChatBloc>(
//         create: (BuildContext context) => ChatBloc(
//         )..add(ChatInitEvent()),
//         child: const ChatViewForm());
//   }
// }
//
//
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:core/di/app_di.dart';
// import 'package:core_ui/core_ui.dart';
// import 'package:data/data.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
//
// class ChatViewScreen extends StatefulWidget {
//   final String chatId;
//   final String chatName;
//   final String userName;
//
//   const ChatViewScreen({
//     Key? key,
//     required this.chatId,
//     required this.chatName,
//     required this.userName,
//   }) : super(key: key);
//
//   @override
//   State<ChatViewScreen> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatViewScreen> {
//   Stream<QuerySnapshot>? messages;
//   var members;
//   String isCompanionTyping = 'false';
//   String messageId = '';
//   PlatformFile? pickedImage;
//   Offset _tapPosition = Offset.zero;
//   DatabaseService databaseService = appLocator<DatabaseService>();
//
//   TextEditingController messageController = TextEditingController();
//   ScrollController scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     gettingChatMessages();
//     gettingMembers();
//   }
//
//   gettingChatMessages() {
//     databaseService.gettingChatMessages(widget.chatId).then((val) {
//       setState(() {
//         messages = val;
//       });
//     });
//   }
//
//   gettingMembers() {
//     databaseService.gettingChatMembers(widget.chatId).then((value) {
//       setState(() {
//         members = value;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         title: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(widget.chatName),
//             GestureDetector(
//               onTapDown: (position) => {_getTapPosition(position)},
//               onLongPress: () => {_showDeleteChatMenu(context, widget.chatId, widget.chatName, widget.userName)},
//               child: Container(
//                 height: 30,
//                 width: 30,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade600,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Icon(
//                     Icons.more_horiz_rounded,
//                     color: Colors.grey.shade800,
//                     size: 25.0,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         backgroundColor: Colors.grey.shade400,
//       ),
//       body: Stack(
//         fit: StackFit.loose,
//         children: <Widget>[
//           // chat messages here
//           chatMessages(),
//           const SizedBox(
//             width: 12,
//             height: 50,
//           ),
//           // Align(
//           //   alignment: Alignment.bottomCenter,
//           //   child: companionTyping(),
//           // ),
//           companionTyping(),
//
//           // SizedBox(
//           //   width: 50,
//           //   height: 50,
//           //   child: isCompanionTyping == 'true'
//           //       ? const SpinKitThreeBounce(size: 20.0, color: Colors.black54,)
//           //       : Container(),
//           // ),
//           Container(
//             alignment: Alignment.bottomCenter,
//             width: MediaQuery.of(context).size.width,
//             padding: const EdgeInsets.only(top: 5.0),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//               width: MediaQuery.of(context).size.width,
//               color: Colors.grey.shade400,
//               child: Row(children: [
//                 GestureDetector(
//                   onTap: () async {
//                     await selectImage();
//                     sendMessage();
//                   },
//                   child: Container(
//                     height: 50,
//                     width: 50,
//                     // decoration: BoxDecoration(
//                     //   color: Theme.of(context).primaryColor,
//                     //   borderRadius: BorderRadius.circular(30),
//                     // ),
//                     child: const Center(
//                         child: Icon(
//                       Icons.add_circle_rounded,
//                       color: Colors.black54,
//                       size: 40.0,
//                     )),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 6,
//                 ),
//                 // GestureDetector(
//                 //   onTap: () async {
//                 //     await selectFile();
//                 //     sendMessage();
//                 //   },
//                 //   child: Container(
//                 //     height: 50,
//                 //     width: 50,
//                 //     // decoration: BoxDecoration(
//                 //     //   color: Theme.of(context).primaryColor,
//                 //     //   borderRadius: BorderRadius.circular(30),
//                 //     // ),
//                 //     child: const Center(
//                 //         child: Icon(
//                 //           Icons.file_present,
//                 //           color: Colors.black54,
//                 //           size: 40.0,
//                 //         )),
//                 //   ),
//                 // ),
//                 const SizedBox(
//                   width: 6,
//                 ),
//                 Expanded(
//                   child: TextFormField(
//                     controller: messageController,
//                     style: const TextStyle(color: Colors.black),
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black54),
//                         borderRadius: BorderRadius.circular(15.0),
//                       ),
//                       filled: true,
//                       fillColor: Colors.black12,
//                       hintText: "Message",
//                       hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
//                       border: InputBorder.none,
//                     ),
//                     onChanged: (text) async {
//                       if (text != '' && editMode == false) {
//                         isTyping = true;
//                       }
//                       if (isTyping == true && editMode == false) {
//                         var members = await databaseService.getChatMembers(widget.chatId);
//                         for (Map<String, dynamic> member in members) {
//                           if (member['name'] == widget.userName) {
//                             member['isTyping'] = "true";
//                           }
//                         }
//                         print('is typing');
//                         await databaseService.chatCollection.doc(widget.chatId).update({'members': members});
//                       }
//                       if (text == '' && editMode == false) {
//                         var members = await databaseService.getChatMembers(widget.chatId);
//                         for (Map<String, dynamic> member in members) {
//                           if (member['name'] == widget.userName) {
//                             member['isTyping'] = "false";
//                           }
//                         }
//                         await databaseService.chatCollection.doc(widget.chatId).update({'members': members});
//                       }
//                     },
//                     onFieldSubmitted: (text) async {
//                       var members = await databaseService.getChatMembers(widget.chatId);
//                       for (Map<String, dynamic> member in members) {
//                         if (member['name'] == widget.userName) {
//                           member['isTyping'] = "false";
//                         }
//                       }
//                       print('finished typing');
//                       await databaseService.chatCollection.doc(widget.chatId).update({'members': members});
//                       setState(() {
//                         isTyping = false;
//                       });
//                     },
//                     onEditingComplete: () async {
//                       var members = await databaseService.getChatMembers(widget.chatId);
//                       for (Map<String, dynamic> member in members) {
//                         if (member['name'] == widget.userName) {
//                           member['isTyping'] = "false";
//                         }
//                       }
//                       print('edit complete');
//                       await databaseService.chatCollection.doc(widget.chatId).update({'members': members});
//                       setState(() {
//                         isTyping = false;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 12,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     editMode ? updateMessage() : sendMessage();
//                   },
//                   child: Container(
//                     height: 50,
//                     width: 50,
//                     // decoration: BoxDecoration(
//                     //   color: Theme.of(context).primaryColor,
//                     //   borderRadius: BorderRadius.circular(30),
//                     // ),
//                     child: Center(
//                       child: editMode
//                           ? const Icon(
//                               Icons.check_circle,
//                               color: Colors.white,
//                             )
//                           : const Icon(
//                               Icons.send_rounded,
//                               color: Colors.black54,
//                               size: 40.0,
//                             ),
//                     ),
//                   ),
//                 )
//               ]),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

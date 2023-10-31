import 'package:core/di/app_di.dart';
import 'package:data/services/auth.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/entity/user/user_entity.dart';
import 'package:data/providers/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsViewScreen extends StatefulWidget {
  const ChatsViewScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChatsViewScreenState();
}

class ChatsViewScreenState extends State<ChatsViewScreen> {
  late TextEditingController controller;
  final currentUser = FirebaseAuth.instance.currentUser;

  late String userName = "";
  AuthService authService = AuthService();
  Stream? chats;
  bool _isLoading = false;
  String chatName = "";
  String resentMessage = "";
  String companionId = "";
  Offset _tapPosition = Offset.zero;
  final DatabaseService databaseService = appLocator<DatabaseService>();
  //UserEntity currentUser = appLocator.get<UserEntity>(instanceName: 'currentUser');

  @override
  void initState() {
    super.initState();
    gettingUserData();
    getUserName();

    controller = TextEditingController();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    // getting the list of snapshots in our stream
    await databaseService.gettingUserData().then((snapshot) {
      setState(() {
        chats = snapshot;
      });
    });
  }

  getUserName() async {
    UserEntity user = await databaseService.getUserData();
    setState(() {
      userName = user.displayName;
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.elementColor,
        title: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'New chat',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: TextButton(
                  style: ButtonStyle(
                    //backgroundColor: MaterialStatePropertyAll(Colors.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        //side: BorderSide(color: Colors.),
                      ),
                    ),
                  ),
                  onPressed: () {
                    popUpDialog(context);
                  },
                  child: /*Text(
                    '+',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),*/
                      Icon(
                    Icons.add_circle,
                    color: Colors.blue.shade800,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: chatList(),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a chat",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                        )
                      : TextField(
                          onChanged: (val) {
                            setState(() {
                              companionId = val;
                            });
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (companionId != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      if (await databaseService.checkExist(companionId)) {
                        databaseService.createChat(userName, companionId).whenComplete(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        _isLoading = false;
                        showSnackbar(context, Colors.red, "this user don't exist.");
                      }
                      // showSnackbar(
                      //     context, Colors.green, "Group created successfully.");
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }

  chatList() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          print('snapshot in not null');
          if (snapshot.data['chats'] != null) {
            print('snapshot have chats');
            if (snapshot.data['chats'].length != 0) {
              return ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: snapshot.data['chats'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['chats'].length - index - 1;

                  return ChatTile(
                      chatId: getId(snapshot.data['chats'][reverseIndex]),
                      chatName: getName(snapshot.data['chats'][reverseIndex]),
                      userName: snapshot.data['displayName']);
                },
              );
            } else {
              print('snapshot');
              return noChatWidget();
            }
          } else {
            print('snapshot wasnt null but doesnt have chats');
            return noChatWidget();
          }
        } else {
          print('snapshot have no data');
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noChatWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any chats, tap on the add icon to create a chat.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
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

// Widget _displayChatList () {
//   return StreamBuilder(stream: FirebaseFirestore.instance.collection('users').snapshots(), builder: (context, snapshot) {
//       return ListView(children:
//           snapshot.data!.docs.map<Widget>((doc) => _buildChatListItem(doc)).toList(),
//       );
//   },);
// }

// Widget _buildChatListItem(DocumentSnapshot document) {
//   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//
//   if (currentUser.uid != data['uid']) {
//     return ListTile(
//       title: data['displayName'],
//       onTap: () {},
//     );
//   }
//   else {
//     return Container();
//   }
// }

//import 'package:core/di/locator_service.dart';
import 'dart:io';

import 'package:core/di/app_di.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile_view.dart';
import '../bloc/profile_view/bloc.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProfileViewScreenState();
}

class ProfileViewScreenState extends State<ProfileViewScreen> {
  late TextEditingController nameController;
  late TextEditingController uidController;
  PlatformFile? pickedFile;
  late bool isEditMode;
  Offset _tapPosition = Offset.zero;

  final currentUser = FirebaseAuth.instance.currentUser;
  //UserEntity currentUser = appLocator.get<UserEntity>(instanceName: 'currentUser');

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    uidController = TextEditingController();
    isEditMode = false;
  }

  @override
  void dispose() {
    nameController.dispose();
    uidController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => appLocator<ProfileBloc>()..add(ProfileInitEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade400,
            title: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTapDown: (position) => {_getTapPosition(position)},
                  onLongPress: () => {_showDeleteChatMenu(context)},
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
                )),
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (BuildContext contextWidget, ProfileState state) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      width: 200,
                      height: 30,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          if (isEditMode == true) {
                            await selectAvatar();
                          }
                        }, // Image tapped
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade800,
                          child: ClipOval(
                            child: Image.network(
                              state.photoURL,
                              width: 250,
                              height: 250,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 200,
                      height: 30,
                    ),
                    SizedBox(
                      width: 300,
                      height: 40,
                      child: TextField(
                        autofocus: false,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'UUID',
                        ),
                        controller: uidController,
                      ),
                    ),
                    const SizedBox(
                      width: 200,
                      height: 10,
                    ),
                    SizedBox(
                      width: 300,
                      height: 40,
                      child: TextField(
                        autofocus: false,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        ),
                        controller: nameController,
                      ),
                    ),
                    const SizedBox(
                      width: 200,
                      height: 10,
                    ),
                    SizedBox(
                      width: 95,
                      height: 35,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue.shade800),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              //side: BorderSide(color: Colors.),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (isEditMode == false) {
                            setState(() {
                              uidController.text = state.uuid;
                              nameController.text = state.displayName;
                              isEditMode = true;
                            });
                          } else {
                            BlocProvider.of<ProfileBloc>(contextWidget)
                                .add(ProfileUpdateEvent(nameController.text, uidController.text));
                            if (pickedFile != null) {
                              BlocProvider.of<ProfileBloc>(contextWidget)
                                  .add(ProfileAvatarEvent(File(pickedFile!.path!)));
                            }
                            setState(() {
                              nameController.clear();
                              uidController.clear();
                              pickedFile = null;
                              isEditMode = false;
                            });
                          }
                          // await openDialog(contextWidget: contextWidget, userEntity: state.userData);
                          // _fetchData(contextWidget: contextWidget, userEntity: state.userData);
                          //BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileFetchedEvent(state.userData));
                          // BlocProvider.of<ProfileBloc>(context).add(ProfileUpdateEvent(currentUser));
                          //BlocProvider.of<ProfileBloc>(context).add(ProfileFetchedEvent(currentUser));
                          // _updateData(contextWidget: contextWidget, userEntity: state.userData);
                        },
                        child: Text(
                          isEditMode == false ? 'Edit Profile' : 'Save',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Text(
                    //   "UUID: ${state.userData.uid}",
                    //   style: TextStyle(fontSize: 15.0),
                    // ),
                    // Text(
                    //   "Name: ${state.userData.displayName}",
                    //   style: TextStyle(fontSize: 20.0),
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
        //  ),
      ),
    );
  }

  Future<void> selectAvatar() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  void _getTapPosition(TapDownDetails tapPosition) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(tapPosition.globalPosition); // store the tap positon in offset variable
    });
  }

  void _showDeleteChatMenu(BuildContext contextWidget) async {
    final RenderObject? overlay = Overlay.of(context).context.findRenderObject();

    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width, overlay.paintBounds.size.height)),
        items: [
          const PopupMenuItem(
            value: "delete",
            child: Text('Delete account'),
          ),
        ]);
    // perform action on selected menu item
    switch (result) {
      case 'delete':
        BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileDeleteEvent());
        break;
    }
  }
}

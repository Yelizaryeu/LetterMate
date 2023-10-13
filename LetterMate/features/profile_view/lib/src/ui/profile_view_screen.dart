//import 'package:core/di/locator_service.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/entity/user/user_entity.dart';
import 'package:data/providers/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  late final DatabaseService databaseService;
  late bool isEditMode;
  Offset _tapPosition = Offset.zero;

  final currentUser = FirebaseAuth.instance.currentUser;
  //UserEntity currentUser = appLocator.get<UserEntity>(instanceName: 'currentUser');

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    uidController = TextEditingController();
    databaseService = DatabaseService(uid: currentUser!.uid);
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
    Future openDialog({required BuildContext contextWidget, required UserEntity userEntity}) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: TextField(
              autofocus: true,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              controller: nameController,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () async {
                  if (userEntity != null) {
                    //databaseService.updateUserData(controller.text, '');
                    userEntity.displayName = nameController.text;
                    changeUserData(contextWidget: contextWidget, userEntity: userEntity);
                    BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileFetchedEvent(userEntity.uid));
                    //appLocator<ProfileBloc>().add(ProfileUpdateEvent(currentUser));
                    //appLocator<ProfileBloc>().add(ProfileFetchedEvent(currentUser));
                    //context.read<ProfileBloc>().add(DatabaseFetchedEvent(currentUser));
                    Navigator.of(context).pop();
                    nameController.clear();
                  }
                },
                child: const Text('SUBMIT'),
              ),
            ],
          ),
        );

    return BlocProvider<ProfileBloc>(
      create: (context) => appLocator<ProfileBloc>()..add(ProfileFetchedEvent(currentUser!.uid)),
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
              )
            ),
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (BuildContext contextWidget, ProfileState state) {
              if (state is ProfileErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is ProfileLoadingState) {
                return const AppLoaderCenterWidget();
              }
              if (state is ProfileLoadedState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            if (isEditMode == true) {
                              await selectAvatar();
                              // await uploadAvatar(
                              //     contextWidget: contextWidget,
                              //     userEntity: state.userData,
                              //     file: File(pickedFile!.path!));
                              //BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileFetchedEvent(state.userData));
                            }
                          }, // Image tapped
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade800,
                            child: ClipOval(
                              child: Image.network(
                                state.userData.photoURL,
                                width: 250,
                                height: 250,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
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
                            hintText:  'UUID',
                          ),
                          controller: uidController,
                        ),
                      ),
                      SizedBox(
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
                      SizedBox(
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
                                uidController.text = state.userData.uuid;
                                nameController.text = state.userData.displayName;
                                isEditMode = true;
                              });
                            } else {
                              state.userData.displayName = nameController.text;
                              print('got name from textfield');
                              state.userData.uuid = uidController.text;
                              print('got uid from textfield');
                              if (pickedFile != null) {
                                print('pickedfile not null so try to upload');
                                await uploadAvatar(
                                    contextWidget: contextWidget,
                                    file: File(pickedFile!.path!),);
                              }
                              print('trying to change data in firestore');
                              await changeUserData(contextWidget: contextWidget, userEntity: state.userData);
                              print('added event to bloc to fetch data');
                              setState(() {
                                //BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileUpdateEvent(state.userData));
                                //appLocator<ProfileBloc>().add(ProfileUpdateEvent(currentUser));
                                //appLocator<ProfileBloc>().add(ProfileFetchedEvent(currentUser));
                                //_fetchData(contextWidget: contextWidget, userEntity: state.userData);
                                BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileFetchedEvent(state.userData.uid));
                                //context.read<ProfileBloc>().add(DatabaseFetchedEvent(currentUser));
                                nameController.clear();
                                uidController.clear();
                                print('setting iseditmode to false');
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
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
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
              }
              return Container();
            },
          ),
        ),
        //  ),
      ),
    );
  }

  _fetchData({required BuildContext contextWidget, required UserEntity userEntity}) {
    print('added ProfileFetchedEvent');
    BlocProvider.of<ProfileBloc>(contextWidget).add(
      ProfileFetchedEvent(userEntity.uid),
    );
  }

  Future selectAvatar() async {
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

  uploadAvatar({required BuildContext contextWidget, required file}) {
    final path = '${currentUser!.uid}/files/avatar/';
    //await databaseService.updateUserPhoto(file, path);
    BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileAvatarEvent(file, path));
  }

  changeUserData({required BuildContext contextWidget, required UserEntity userEntity}) {
    print('added ProfileUpdateEvent');
    BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileUpdateEvent(userEntity),);
  }

  void _getTapPosition(TapDownDetails tapPosition){
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(tapPosition.globalPosition);   // store the tap positon in offset variable
      print(_tapPosition);
    });
  }

  void _showDeleteChatMenu(BuildContext contextWidget) async {
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
            child: Text('Delete account'),
            value: "delete",
          ),
        ]);
    // perform action on selected menu item
    switch (result) {
      case 'delete':
        databaseService.deleteAccount();
        break;
    }
  }


  Future<void> uploadImage(Uint8List file, String storagePath) async =>
      await FirebaseStorage.instance.ref().child(storagePath).putData(file);
//.then((task) => task.ref.getDownloadURL());
}

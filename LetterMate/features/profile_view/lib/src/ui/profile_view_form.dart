import 'dart:io';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile_view.dart';
import '../bloc/profile_view/bloc.dart';

class ProfileViewForm extends StatefulWidget {
  const ProfileViewForm({super.key});

  @override
  State<ProfileViewForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileViewForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController uuidController = TextEditingController();

  @override
  Widget build(BuildContext contextWidget) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: AppTheme.elementColor,
              title: Align(
                alignment: Alignment.centerRight,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppTheme.darkElementColor,
                      borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_10),
                    ),
                    child: PopupMenuButton(
                      offset: const Offset(
                        AppDimens.OFFSET_0,
                        AppDimens.OFFSET_50,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.more_horiz_rounded,
                          color: AppTheme.darkerElementColor,
                          size: AppDimens.BORDER_RADIUS_23,
                        ),
                      ),
                      itemBuilder: (BuildContext contextWidget) {
                        return <PopupMenuItem>[
                          PopupMenuItem(
                            height: AppDimens.popUpMenuHeight,
                            child: const Text('Delete account'),
                            onTap: () {
                              BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileDeleteEvent());
                            },
                          ),
                        ];
                      },
                    ),
                  ),
                ),
              ),
            ),
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (BuildContext contextWidget, ProfileState state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimens.PADDING_25,
                          bottom: AppDimens.PADDING_10,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: AppTheme.elementColor,
                              child: ClipOval(
                                child: Image.network(
                                  state.photoURL,
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (state.isEditMode == true)
                              GestureDetector(
                                onTap: () async {
                                  if (state.isEditMode == true) {
                                    BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileSelectAvatarEvent());
                                  }
                                },
                                child: const Icon(
                                  Icons.add_circle_outlined,
                                  size: AppDimens.BORDER_RADIUS_40,
                                  color: AppTheme.elementColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimens.PADDING_10,
                          bottom: AppDimens.PADDING_10,
                          right: AppDimens.PADDING_20,
                          left: AppDimens.PADDING_20,
                        ),
                        child: AppTextField(
                          controller: uuidController,
                          hintText: 'UUID',
                          disabled: !state.isEditMode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimens.PADDING_10,
                          bottom: AppDimens.PADDING_10,
                          right: AppDimens.PADDING_20,
                          left: AppDimens.PADDING_20,
                        ),
                        child: AppTextField(
                          controller: nameController,
                          hintText: 'Name',
                          disabled: !state.isEditMode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimens.PADDING_10,
                          bottom: AppDimens.PADDING_10,
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(AppTheme.buttonsColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_8),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (state.isEditMode == false) {
                              uuidController.text = state.uuid;
                              nameController.text = state.displayName;
                              BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileEditModeEvent());
                            } else {
                              if (state.pickedFile != '') {
                                BlocProvider.of<ProfileBloc>(contextWidget)
                                    .add(ProfileAvatarEvent(File(state.pickedFile)));
                              }
                              BlocProvider.of<ProfileBloc>(contextWidget)
                                  .add(ProfileUpdateEvent(nameController.text, uuidController.text));
                              nameController.clear();
                              uuidController.clear();
                            }
                          },
                          child: Text(
                            state.isEditMode == false ? 'Edit Profile' : 'Save',
                            style: AppFonts.bold12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    uuidController.dispose();
    nameController.dispose();
    super.dispose();
  }
}

import 'dart:io';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../profile_view.dart';
import '../bloc/profile_view/bloc.dart';

class ProfileViewForm extends StatefulWidget {
  const ProfileViewForm({super.key});

  @override
  State<ProfileViewForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileViewForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _uuidController = TextEditingController();

  @override
  void dispose() {
    _uuidController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextWidget) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.grey,
            title: Align(
              alignment: Alignment.centerRight,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
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
                        color: AppColors.darkerGrey,
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
                            backgroundColor: AppColors.grey,
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
                                color: AppColors.grey,
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
                        controller: _uuidController,
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
                        controller: _nameController,
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
                          backgroundColor: const MaterialStatePropertyAll(AppColors.blue),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_8),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (state.isEditMode == false) {
                            _uuidController.text = state.uuid;
                            _nameController.text = state.displayName;
                            BlocProvider.of<ProfileBloc>(contextWidget).add(ProfileEditModeEvent());
                          } else {
                            if (state.pickedFile != '') {
                              BlocProvider.of<ProfileBloc>(contextWidget)
                                  .add(ProfileAvatarEvent(File(state.pickedFile)));
                            }
                            BlocProvider.of<ProfileBloc>(contextWidget)
                                .add(ProfileUpdateEvent(_nameController.text, _uuidController.text));
                            _nameController.clear();
                            _uuidController.clear();
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
        );
      },
    );
  }
}

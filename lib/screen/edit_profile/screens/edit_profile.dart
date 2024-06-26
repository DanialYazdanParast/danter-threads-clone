import 'dart:io';

import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:danter/screen/edit_profile/screens/edit_fild.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';

import 'package:danter/core/widgets/image.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void dispose() {
    editProfileBloc.close();
    VariableConstants.selectedImageedit = null;

    super.dispose();
  }

  final editProfileBloc = EditProfileBloc(locator.get());
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider.value(
      value: editProfileBloc,
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is SendSuccessEditProfileState) {
            BlocProvider.of<ProfileBloc>(context)
                .add(ProfileRefreshEvent(user: AuthRepository.readid()));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          String bio = state is ChengSuccessEditProfileState
              ? state.bio
              : (AuthRepository.loadAuthInfo()!.bio.isNotEmpty)
                  ? AuthRepository.loadAuthInfo()!.bio
                  : "+ Writr bio";

          String name = state is ChengSuccessEditProfileState
              ? state.name
              : (AuthRepository.loadAuthInfo()!.name.isEmpty)
                  ? AuthRepository.loadAuthInfo()!.username
                  : AuthRepository.loadAuthInfo()!.name;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        if (state is ChengSuccessEditProfileState ||
                            VariableConstants.selectedImageedit != null) {
                          BlocProvider.of<EditProfileBloc>(context)
                              .add(SendBioAndNameEditProfileEvent(
                            userid: AuthRepository.readid(),
                            bio: bio == '+ Writr bio' ? '' : bio,
                            name: name,
                            image: VariableConstants.selectedImageedit,
                          ));
                        }
                      },
                      child: state is LodingEditProfileState
                          ? SizedBox(
                              height: 22,
                              width: 22,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: themeData.colorScheme.secondary,
                                ),
                              ),
                            )
                          : Text(
                              'Done',
                              style: state is ChengSuccessEditProfileState ||
                                      VariableConstants.selectedImageedit !=
                                          null
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)
                                  : Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.multiply,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                  left: !RootScreen.isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.2
                      : 20,
                  right: !RootScreen.isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.2
                      : 20),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: themeData.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 0.5,
                        color: themeData.colorScheme.secondary,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: editProfileBloc,
                                child: EditScreenFild(
                                  bio: bio,
                                  name: name,
                                  nameFild: 'Name',
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            color: themeData.scaffoldBackgroundColor,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w300)),
                                      ),
                                    ],
                                  ),
                                ),
                                (AuthRepository.loadAuthInfo()!
                                        .avatarchek
                                        .isNotEmpty)
                                    ? GestureDetector(
                                        onTap: () {
                                          _pickImage();
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: SizedBox(
                                              height: 47,
                                              width: 47,
                                              child: VariableConstants
                                                          .selectedImageedit !=
                                                      null
                                                  ? Image.file(
                                                      VariableConstants
                                                          .selectedImageedit!,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : ImageLodingService(
                                                      imageUrl: AuthRepository
                                                              .loadAuthInfo()!
                                                          .avatar)),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          _pickImage();
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Container(
                                            height: 47,
                                            width: 47,
                                            color: const Color(0xffDBDBDB),
                                            child: VariableConstants
                                                        .selectedImageedit !=
                                                    null
                                                ? Image.file(
                                                    VariableConstants
                                                        .selectedImageedit!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : const Icon(
                                                    CupertinoIcons
                                                        .person_add_solid,
                                                    color: Colors.black,
                                                    size: 26,
                                                  ),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Divider(
                              color: themeData.colorScheme.secondary,
                              thickness: 0.8),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: editProfileBloc,
                                child: EditScreenFild(
                                  bio: bio == '+ Writr bio' ? '' : bio,
                                  name: name,
                                  nameFild: 'Bio',
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            color: themeData.scaffoldBackgroundColor,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bio',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(bio,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _pickImage() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;
    setState(() {
      VariableConstants.selectedImageedit = File(pickedFile.path);
    });
  }
}

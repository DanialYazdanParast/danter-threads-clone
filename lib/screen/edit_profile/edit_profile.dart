import 'dart:io';

import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:danter/screen/edit_profile/edit_fild.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

File? selectedImageedit;

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void dispose() {
    editProfileBloc.close();
    selectedImageedit = null;

    super.dispose();
  }

  final editProfileBloc = EditProfileBloc(locator.get());
  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Edit Profile'),
              actions: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        if (state is ChengSuccessEditProfileState || selectedImageedit !=null) {
                          BlocProvider.of<EditProfileBloc>(context)
                              .add(SendBioAndNameEditProfileEvent(
                            userid: AuthRepository.readid(),
                            bio: bio,
                            name: name,
                            image: selectedImageedit,
                          ));
                        }
                      },
                      child: state is LodingEditProfileState
                          ? CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : Text(
                              'Done',
                              style: TextStyle(
                                  fontFamily: 'Shabnam',
                                  fontSize: 18,
                                  color:
                                      state is ChengSuccessEditProfileState ||
                                              selectedImageedit != null
                                          ? Colors.black
                                          : LightThemeColors.secondaryTextColor,
                                  fontWeight: FontWeight.w600),
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
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 0.5,
                        color: LightThemeColors.secondaryTextColor,
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
                                  bio: bio
                                          ,
                                  name: name,
                                  nameFild: 'Name',
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Name'),
                                    Text(name),
                                  ],
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
                                              child: selectedImageedit != null
                                                  ? Image.file(
                                                      selectedImageedit!,
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
                                            color: LightThemeColors
                                                .secondaryTextColor
                                                .withOpacity(0.4),
                                            child: selectedImageedit != null
                                                ? Image.file(
                                                    selectedImageedit!,
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
                        const Padding(
                          padding: EdgeInsets.only(right: 70),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: editProfileBloc,
                                child: EditScreenFild(
                                   bio: bio
                                          ,
                                  name: name,
                                  nameFild: 'Bio',
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Bio'),
                                Text(
                                  bio,
                                  // style: TextStyle(
                                  //   fontFamily: 'Shabnam',
                                  //   color: (AuthRepository.loadAuthInfo()!
                                  //           .bio
                                  //           .isNotEmpty)
                                  //       ? Colors.black
                                  //       : LightThemeColors.secondaryTextColor,
                                  // ),
                                ),
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

  Future _pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImageedit = File(returnImage.path);
    });
  }
}

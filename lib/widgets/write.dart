import 'dart:io';

import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File? selectedImage;

class FildWrite extends StatefulWidget {
  FildWrite({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  State<FildWrite> createState() => _FildWriteState();
}

class _FildWriteState extends State<FildWrite> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (AuthRepository.loadAuthInfo()!.avatarchek.isNotEmpty)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                            height: 47,
                            width: 47,
                            child: ImageLodingService(
                                imageUrl:
                                    AuthRepository.loadAuthInfo()!.avatar)),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 47,
                          width: 47,
                          color: LightThemeColors.secondaryTextColor
                              .withOpacity(0.4),
                          child: const Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.white,
                            size: 55,
                          ),
                        ),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AuthRepository.loadAuthInfo()!.username,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextField(
                          controller: widget._controller,
                          onChanged: (value) {
                            setState(() {
                              widget._controller;
                            });
                          },
                          minLines: 1,
                          maxLines: 50,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            // floatingLabelBehavior:
                            //     FloatingLabelBehavior.always,
                            alignLabelWithHint: false,
                            label: Text(
                              'Start a danter',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: const Icon(Icons.add_a_photo_outlined)),
                        const SizedBox(
                          height: 60,
                        ),
                        selectedImage != null
                            ? Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        selectedImage!,
                                      )),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedImage = null;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: LightThemeColors
                                                .secondaryTextColor
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: const Icon(
                                          CupertinoIcons.multiply,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          (widget._controller.text.isNotEmpty)
              ? GestureDetector(
                  onTap: () {
                    widget._controller.text = '';
                  },
                  child: const Icon(
                    CupertinoIcons.multiply,
                    color: LightThemeColors.secondaryTextColor,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future _pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
    });
  }
}

import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/screen/image/screens/image_screen.dart';
import 'package:danter/core/widgets/image.dart';

import 'package:flutter/material.dart';

class ImagePost extends StatelessWidget {
  const ImagePost({
    super.key,
    required this.postEntity,
    required this.namepage,
    this.leftpading = 55,
  });
  final PostEntity postEntity;
  final double leftpading;
  final String namepage;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return postEntity.image.isNotEmpty && postEntity.image.length < 2
        ? Padding(
            padding: EdgeInsets.only(right: 10, left: leftpading, bottom: 16),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: 266,
                  minHeight: 266,
                  minWidth: MediaQuery.of(context).size.width),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                    builder: (context) => ImageScreen(
                      color: themeData.scaffoldBackgroundColor,
                      brightness:
                          themeData.colorScheme.brightness == Brightness.dark
                              ? Brightness.light
                              : Brightness.dark,
                      pagename: namepage,
                      indeximage: 0,
                      postEntity: postEntity,
                    ),
                  ));
                },
                child: Hero(
                  tag: '$namepage${postEntity.image[0]}',
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ImageLodingService(
                        imageUrl:
                            '${VariableConstants.imageaddress}${postEntity.id}/${postEntity.image[0]}',
                      )),
                ),
              ),
            ))
        : postEntity.image.length > 1
            ? SizedBox(
                height: 266,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: postEntity.image.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            bottom: 16,
                            left: (index == 0) ? leftpading : 10,
                            right: (index == postEntity.image.length - 1)
                                ? 10
                                : 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 200,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ImageScreen(
                                    brightness:
                                        themeData.colorScheme.brightness ==
                                                Brightness.dark
                                            ? Brightness.light
                                            : Brightness.dark,
                                    color: themeData.scaffoldBackgroundColor,
                                    pagename: namepage,
                                    indeximage: index,
                                    postEntity: postEntity,
                                  ),
                                ));
                              },
                              child: Hero(
                                tag: '$namepage${postEntity.image[index]}',
                                child: ImageLodingService(
                                  imageUrl:
                                      '${VariableConstants.imageaddress}${postEntity.id}/${postEntity.image[index]}',
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              )
            : Container();
  }
}

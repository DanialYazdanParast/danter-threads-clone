import 'package:danter/data/model/post.dart';
import 'package:danter/screen/image/image_screen.dart';
import 'package:danter/widgets/image.dart';

import 'package:flutter/material.dart';

class ImagePost extends StatelessWidget {
  const ImagePost({super.key, required this.postEntity , this.leftpading =65});
  final PostEntity postEntity;
  final double leftpading;

  @override
  Widget build(BuildContext context) {
    return postEntity.image.isNotEmpty && postEntity.image.length < 2
        ? Padding(
            padding:  EdgeInsets.only(right: 10, left: leftpading, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                  builder: (context) => ImageScreen(
                    indeximage: 0,
                    postEntity: postEntity,
                  ),
                ));
              },
              child: Hero(
                tag: postEntity.image[0],
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      child: ImageLodingService(
                        imageUrl:
                            'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[0]}',
                      ),
                    )),
              ),
            ),
          )
        : postEntity.image.length > 1
            ? SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: postEntity.image.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            bottom: 10,
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
                                    indeximage: index,
                                    postEntity: postEntity,
                                  ),
                                ));
                              },
                              child: Hero(
                                tag: postEntity.image[index],
                                child: ImageLodingService(
                                  imageUrl:
                                      'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[index]}',
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

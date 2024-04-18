import 'package:danter/core/widgets/image.dart';
import 'package:flutter/material.dart';

class ImageReplyUser extends StatelessWidget {
  const ImageReplyUser({
    super.key,
    required this.photo,
  });

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 19,
      width: 19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 1,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      child: ImageLodingService(
        borderRadius: BorderRadius.circular(
          100,
        ),
        imageUrl: photo,
      ),
    );
  }
}

class PhotoReplyUserNoPhoto extends StatelessWidget {
  const PhotoReplyUserNoPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 21,
        width: 21,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 2,
              color: Theme.of(context).scaffoldBackgroundColor,
            )),
        child: Image.asset('assets/images/profile.png'));
  }
}

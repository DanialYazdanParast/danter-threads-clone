
import 'package:danter/theme.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoUserFollowers extends StatelessWidget {
  const PhotoUserFollowers({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
            child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
              color: LightThemeColors.secondaryTextColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 2, color: Colors.white)),
        )),
        Positioned(
          left: 13,
          bottom: 0,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
                color: LightThemeColors.secondaryTextColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.white)),
          ),
        )
      ],
    );
  }
}



class ImageReplyUser extends StatelessWidget {
  const ImageReplyUser({
    super.key,
    required this.photo,
  });

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 2,
          color: Colors.white,
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
      height: 22,
      width: 22,
      decoration: BoxDecoration(
          color: LightThemeColors.secondaryTextColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: Colors.white)),
      child: const Icon(
        CupertinoIcons.person_fill,
        color: Colors.white,
        size: 22,
      ),
    );
  }
}

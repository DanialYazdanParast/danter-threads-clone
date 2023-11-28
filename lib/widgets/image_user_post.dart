
import 'package:danter/data/model/post.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageUserPost extends StatelessWidget {
  const ImageUserPost({
    super.key,
    required this.postEntity,
  });

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (postEntity.user.avatarchek.isNotEmpty)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                  height: 47,
                  width: 47,
                  child: ImageLodingService(imageUrl: postEntity.user.avatar)),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 47,
                width: 47,
                color: LightThemeColors.secondaryTextColor.withOpacity(0.4),
                child: const Icon(
                  CupertinoIcons.person_fill,
                  color: Colors.white,
                  size: 55,
                ),
              ),
            ),
    );
  }
}
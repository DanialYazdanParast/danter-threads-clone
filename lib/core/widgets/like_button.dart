import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LikeButton extends StatefulWidget {
  const LikeButton(
      {super.key, required this.postEntity, required this.onTabLike});
  final PostEntity postEntity;
  final GestureTapCallback onTabLike;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    bool liked = widget.postEntity.likes.contains(AuthRepository.readid());
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
        onTap: widget.onTabLike,
        child: liked
            ? const Icon(CupertinoIcons.heart_fill, color: Colors.red, size: 20)
                .animate(target: liked ? 1 : 0)
                .scaleXY(duration: 400.ms, begin: 1.0, end: 1.2)
                .then()
                .scaleXY(duration: 400.ms, begin: 1.2, end: 1.0)
            : Icon(
                CupertinoIcons.heart,
                size: 20,
                color: themeData.colorScheme.onPrimary,
              )
                .animate(target: liked ? 1 : 0)
                .scaleXY(duration: 400.ms, begin: 1.0, end: 1.2)
                .then()
                .scaleXY(duration: 400.ms, begin: 1.2, end: 1.0));
  }
}

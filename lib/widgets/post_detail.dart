import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/likes/likes_Screen.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/screen/replies/replies_screen.dart';
import 'package:danter/screen/replies/write_reply/write_reply.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/Row_Image_Name_Text.dart';
import 'package:danter/widgets/image_post.dart';
import 'package:danter/widgets/photoUserFollowers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PostDetail extends StatelessWidget {
  final PostEntity postEntity;

  final GestureTapCallback onTabmore;
  final GestureTapCallback onTabLike;

  const PostDetail({
    super.key,
    required this.postEntity,
    required this.onTabmore,
    required this.onTabLike,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => RepliesScreen(
            postEntity: postEntity,
          ),
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: themeData.scaffoldBackgroundColor,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 28,
              top: 44,
              bottom: 50,
              child: Container(
                width: postEntity.replies.length > 0 ? 1 : 0,
                color: LightThemeColors.secondaryTextColor,
              ),
            ),
            Column(
              children: [
                ImageAndNameAndText(
                    postEntity: postEntity,
                    onTabNameUser: () {
                      if (postEntity.user.id == AuthRepository.readid()) {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileScreen();
                            },
                          ),
                        );
                      } else {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileUser(
                                user: postEntity.user,
                              );
                            },
                          ),
                        );
                      }
                    },
                    onTabmore: onTabmore),
                ImagePost(postEntity: postEntity),
                Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Row(
                    children: [
                      LikeButton(postEntity: postEntity, onTabLike: onTabLike),

                      // GestureDetector(
                      //   onTap: onTabLike,
                      //   child: Container(
                      //     child:
                      //         postEntity.likes.contains(AuthRepository.readid())
                      //             ? const Icon(CupertinoIcons.heart_fill,
                      //                 color: Colors.red, size: 24)
                      //             : const Icon(
                      //                 CupertinoIcons.heart,
                      //                 size: 24,
                      //               ),
                      //   ),
                      // ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                            builder: (context) => WriteReply(
                                postEntity: postEntity, namePage: ''),
                          ));
                        },
                        child: SizedBox(
                          height: 22,
                          width: 22,
                          child: Image.asset(
                            'assets/images/comments.png',
                            color: themeData.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    top: (postEntity.replies.isNotEmpty ||
                            postEntity.likes.isNotEmpty)
                        ? 8
                        : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      postEntity.replies.length > 1
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                (postEntity.replies[0].avatarchek.isNotEmpty)
                                    ? ImageReplyUser(
                                        photo: postEntity.replies[0].avatar,
                                      )
                                    : const PhotoReplyUserNoPhoto(),
                                Positioned(
                                  left: 13,
                                  bottom: 0,
                                  child: (postEntity
                                          .replies[1].avatarchek.isNotEmpty)
                                      ? ImageReplyUser(
                                          photo: postEntity.replies[1].avatar,
                                        )
                                      : const PhotoReplyUserNoPhoto(),
                                )
                              ],
                            )
                          : postEntity.replies.length == 1
                              ? Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, top: 2),
                                  child: (postEntity
                                          .replies[0].avatarchek.isNotEmpty)
                                      ? ImageReplyUser(
                                          photo: postEntity.replies[0].avatar,
                                        )
                                      : const PhotoReplyUserNoPhoto(),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(left: 30),
                                ),
                      SizedBox(width: postEntity.replies.length > 1 ? 27 : 15),
                      Visibility(
                        visible: postEntity.replies.isNotEmpty,
                        child: Row(
                          children: [
                            Text(postEntity.replies.length.toString(),
                                style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(width: 6),
                            Text(
                                postEntity.replies.length <= 1
                                    ? 'reply'
                                    : 'replies',
                                style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(width: 18),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: postEntity.likes.isNotEmpty,
                        child: Row(
                          children: [
                            Text(postEntity.likes.length.toString(),
                                style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                  builder: (context) => LikesScreen(
                                    idpostEntity: postEntity.id,
                                  ),
                                ));
                              },
                              child: Text(
                                  postEntity.likes.length <= 1
                                      ? 'Like'
                                      : 'Likes',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                    height: 20,
                    color: themeData.colorScheme.secondary.withOpacity(0.5),
                    thickness: 0.7),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton(
      {super.key, required this.postEntity, required this.onTabLike});
  final PostEntity postEntity;
  final GestureTapCallback onTabLike;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  // void togglrButton() {
  //   setState(() {
  //     liked = !liked;
  //   });
  // }

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

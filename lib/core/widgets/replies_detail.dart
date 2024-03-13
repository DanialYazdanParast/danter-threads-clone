import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/likes/likes_Screen.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/screen/replies/replies_screen.dart';
import 'package:danter/screen/replies/write_reply/write_reply.dart';
import 'package:danter/core/widgets/Row_Image_Name_Text.dart';
import 'package:danter/core/widgets/image_post.dart';
import 'package:danter/core/widgets/photoUserFollowers.dart';
import 'package:danter/core/widgets/post_detail.dart';

import 'package:flutter/material.dart';

class RepliseDtaile extends StatelessWidget {
  final PostReply postEntity;
  final GestureTapCallback onTabLikeReplyTo;
  final GestureTapCallback onTabLikeMyReply;
  final GestureTapCallback onTabNameUser;
  final GestureTapCallback onTabmore;
  final String namepage;
  const RepliseDtaile({
    super.key,
    required this.postEntity,
    required this.onTabNameUser,
    required this.onTabmore,
    required this.onTabLikeReplyTo,
    required this.onTabLikeMyReply,
    required this.namepage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          ReplyTo(
            namepage: namepage,
            onTabLike: onTabLikeReplyTo,
            onTabNameUser: () {
              if (postEntity.replyTo.user.id == AuthRepository.readid()) {
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
                        user: postEntity.replyTo.user,
                      );
                    },
                  ),
                );
              }
            },
            onTabmore: () {},
            postEntity: postEntity.replyTo,
            onTaNavigator: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => RepliesScreen(
                  pagename: namepage,
                  postEntity: postEntity.replyTo,
                ),
              ));
            },
          ),
          MyReply(
            namepage: namepage,
            onTabLike: onTabLikeMyReply,
            onTabNameUser: () {
              if (postEntity.myReply.user.id == AuthRepository.readid()) {
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
                        user: postEntity.myReply.user,
                      );
                    },
                  ),
                );
              }
            },
            onTabmore: onTabmore,
            postEntity: postEntity.myReply,
            onTaNavigator: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => RepliesScreen(
                  pagename: namepage,
                  postEntity: postEntity.replyTo,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class MyReply extends StatelessWidget {
  const MyReply(
      {super.key,
      required this.onTabLike,
      required this.onTabNameUser,
      required this.onTabmore,
      required this.postEntity,
      required this.namepage,
      required this.onTaNavigator});
  final GestureTapCallback onTabLike;
  final GestureTapCallback onTabNameUser;
  final GestureTapCallback onTabmore;
  final PostEntity postEntity;
  final GestureTapCallback onTaNavigator;
  final String namepage;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTaNavigator,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: themeData.scaffoldBackgroundColor,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 28,
              top: 50,
              bottom: 50,
              child: Container(
                width: postEntity.replies.length > 0 ? 1 : 0,
                color: LightThemeColors.secondaryTextColor,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                ImageAndNameAndText(
                    postEntity: postEntity,
                    onTabNameUser: onTabNameUser,
                    onTabmore: onTabmore),
                ImagePost(postEntity: postEntity, namepage: namepage),
                Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Row(
                    children: [
                      LikeButton(postEntity: postEntity, onTabLike: onTabLike),
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

class ReplyTo extends StatelessWidget {
  const ReplyTo(
      {super.key,
      required this.onTabLike,
      required this.onTabNameUser,
      required this.onTabmore,
      required this.postEntity,
      required this.namepage,
      required this.onTaNavigator});
  final GestureTapCallback onTabLike;
  final GestureTapCallback onTabNameUser;
  final GestureTapCallback onTabmore;
  final PostEntity postEntity;
  final GestureTapCallback onTaNavigator;
  final String namepage;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTaNavigator,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: themeData.scaffoldBackgroundColor,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 28,
              top: 44,
              bottom: 20,
              child: Container(
                width: postEntity.replies.length > 0 ? 1 : 0,
                color: LightThemeColors.secondaryTextColor,
              ),
            ),
            Positioned(
                left: 10.7,
                bottom: 0,
                child: SizedBox(
                  height: 23,
                  width: 23,
                  child: Image.asset(
                    'assets/images/fold.png',
                    color: LightThemeColors.secondaryTextColor,
                  ),
                )),
            Column(
              children: [
                ImageAndNameAndText(
                    replypage: true,
                    postEntity: postEntity,
                    onTabNameUser: onTabNameUser,
                    onTabmore: onTabmore),
                ImagePost(postEntity: postEntity, namepage: namepage),
                Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Row(
                    children: [
                      LikeButton(postEntity: postEntity, onTabLike: onTabLike),
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
                    left: 55,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

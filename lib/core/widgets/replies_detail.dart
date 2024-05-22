import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/widgets/like_button.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/screen/likes/screens/likes_screen.dart';
import 'package:danter/screen/profile/screens/profile_screen.dart';
import 'package:danter/screen/profile_user/screens/profile_user.dart';
import 'package:danter/screen/replies/screens/replies_screen.dart';
import 'package:danter/core/widgets/row_image_name_text.dart';
import 'package:danter/core/widgets/image_post.dart';
import 'package:danter/core/widgets/photo_user_followers.dart';
import 'package:danter/screen/root/screens/root.dart';

import 'package:danter/screen/write_reply/screens/write_reply.dart';

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
                      return const ProfileScreen();
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
              if (!RootScreen.isMobile(context)) {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(
                  builder: (context) => RepliesScreen(
                    pagename: namepage,
                    postEntity: postEntity.replyTo,
                  ),
                ));
              } else {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                  builder: (context) => RepliesScreen(
                    pagename: namepage,
                    postEntity: postEntity.replyTo,
                  ),
                ));
              }
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
                      return const ProfileScreen();
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
              if (!RootScreen.isMobile(context)) {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(
                  builder: (context) => RepliesScreen(
                    pagename: namepage,
                    postEntity: postEntity.replyTo,
                  ),
                ));
              } else {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                  builder: (context) => RepliesScreen(
                    pagename: namepage,
                    postEntity: postEntity.replyTo,
                  ),
                ));
              }
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
                width: postEntity.replies.isNotEmpty ? 1 : 0,
                color: LightThemeColors.secondaryTextColor,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 8),
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
                          Navigator.of(context,
                                  rootNavigator: RootScreen.isMobile(context)
                                      ? true
                                      : false)
                              .push(MaterialPageRoute(
                            builder: (context) => WriteReply(
                                postEntity: postEntity, namePage: ''),
                          ));
                        },
                        child: SizedBox(
                          height: 19,
                          width: 19,
                          child: Image.asset(
                            'assets/images/comments.png',
                            color: themeData.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/images/repost.png',
                          color: themeData.colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 19,
                        width: 19,
                        child: Image.asset(
                          'assets/images/send.png',
                          color: themeData.colorScheme.onPrimary,
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
                        ? 12
                        : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                      const EdgeInsets.only(left: 7, top: 2),
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
                      SizedBox(width: postEntity.replies.length > 1 ? 27 : 16),
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
                            const SizedBox(width: 6),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: postEntity.likes.isNotEmpty &&
                            postEntity.replies.isNotEmpty,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 6,
                              width: 6,
                              child: Image.asset(
                                'assets/images/dot.png',
                                color: themeData.colorScheme.onSecondary,
                              ),
                            ),
                            const SizedBox(width: 6),
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
                width: postEntity.replies.isNotEmpty ? 1 : 0,
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
                          height: 19,
                          width: 19,
                          child: Image.asset(
                            'assets/images/comments.png',
                            color: themeData.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/images/repost.png',
                          color: themeData.colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 19,
                        width: 19,
                        child: Image.asset(
                          'assets/images/send.png',
                          color: themeData.colorScheme.onPrimary,
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
                        ? 12
                        : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                  margin: const EdgeInsets.only(top: 2),
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
                      SizedBox(width: postEntity.replies.length > 1 ? 27 : 16),
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
                            const SizedBox(width: 6),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: postEntity.likes.isNotEmpty &&
                            postEntity.replies.isNotEmpty,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 6,
                              width: 6,
                              child: Image.asset(
                                'assets/images/dot.png',
                                color: themeData.colorScheme.onSecondary,
                              ),
                            ),
                            const SizedBox(width: 6),
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

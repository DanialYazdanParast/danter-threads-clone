import 'package:danter/core/extensions/global_extensions.dart';
import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/image_post.dart';
import 'package:danter/core/widgets/image_user_post.dart';
import 'package:danter/core/widgets/like_button.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/core/widgets/time.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/likes/screens/likes_screen.dart';
import 'package:danter/screen/profile/screens/profile_screen.dart';
import 'package:danter/screen/profile_user/screens/profile_user.dart';
import 'package:danter/screen/replies/bloc/reply_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThePostReply extends StatelessWidget {
  const ThePostReply({
    super.key,
    required this.postEntity,
    required this.onTabLike,
    required this.onTabReply,
    required this.context2,
    required this.pagename,
  });
  final BuildContext context2;
  final PostEntity postEntity;
  final GestureTapCallback onTabLike;
  final GestureTapCallback onTabReply;
  final String pagename;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: postEntity.text.textdirection()
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageUserPost(
                  user: postEntity.user,
                  onTabNameUser: () {
                    if (postEntity.user.id == AuthRepository.readid()) {
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
                              user: postEntity.user,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (postEntity.user.id ==
                                    AuthRepository.readid()) {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const ProfileScreen();
                                      },
                                    ),
                                  );
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
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
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    postEntity.user.username,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(width: 4),
                                  Visibility(
                                    visible: postEntity.user.tik,
                                    child: SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: Image.asset(
                                            'assets/images/tik.png')),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            TimePost(created: postEntity.created),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (postEntity.user.id ==
                                    AuthRepository.readid()) {
                                  showModalBottomSheet(
                                    barrierColor: themeData
                                        .colorScheme.onSecondary
                                        .withOpacity(0.1),
                                    context: context,
                                    useRootNavigator: true,
                                    backgroundColor:
                                        themeData.scaffoldBackgroundColor,
                                    //  showDragHandle: true,
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    builder: (context3) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 4,
                                            width: 32,
                                            decoration: BoxDecoration(
                                                color: themeData
                                                    .colorScheme.secondary,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50, bottom: 24),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  useRootNavigator: true,
                                                  barrierDismissible: false,
                                                  barrierColor: themeData
                                                      .colorScheme.onSecondary
                                                      .withOpacity(0.1),
                                                  context: context,
                                                  builder: (context) {
                                                    return CustomAlertDialog(
                                                      button: 'Delete',
                                                      title:
                                                          "Delete this Post?",
                                                      description: "",
                                                      onTabRemove: () {
                                                        BlocProvider.of<
                                                                    ReplyBloc>(
                                                                context2)
                                                            .add(DeletRplyPostEvent(
                                                                postid:
                                                                    postEntity
                                                                        .id));

                                                        Navigator.pop(context);

                                                        Navigator.pop(context3);

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          snackBarApp(
                                                              themeData,
                                                              'با موفقیت حذف شد',
                                                              55),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: themeData.colorScheme
                                                        .onBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Center(
                                                          child: Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            //        fontWeight: FontWeight.bold,
                                                            color: Colors.red,
                                                            fontSize: 18),
                                                      )),
                                                      Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Icon(
                                Icons.more_horiz,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          postEntity.text != ''
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
                  child: Text(postEntity.text,
                      textDirection: postEntity.text.textdirection()
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(height: 1.2)))
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          ImagePost(postEntity: postEntity, leftpading: 10, namepage: pagename),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        LikeButton(
                          postEntity: postEntity,
                          onTabLike: onTabLike,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: onTabReply,
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
                    SizedBox(
                      height: (postEntity.replies.isNotEmpty ||
                              postEntity.likes.isNotEmpty)
                          ? 12
                          : 0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: postEntity.replies.isNotEmpty,
                          child: Row(
                            children: [
                              Text(postEntity.replies.length.toString(),
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              const SizedBox(width: 6),
                              Text(
                                  postEntity.replies.length <= 1
                                      ? 'reply'
                                      : 'replies',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
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
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
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
                  ],
                ),
              ),
            ],
          ),
          Divider(
              height: 20,
              color: themeData.colorScheme.secondary.withOpacity(0.5),
              thickness: 0.7),
        ],
      ),
    );
  }
}

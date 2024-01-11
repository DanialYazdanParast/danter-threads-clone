import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/image/image_screen.dart';
import 'package:danter/screen/likes/likes_Screen.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/screen/replies/bloc/reply_bloc.dart';
import 'package:danter/screen/replies/write_reply/write_reply.dart';
import 'package:danter/theme.dart';

import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image.dart';
import 'package:danter/widgets/image_post.dart';
import 'package:danter/widgets/image_user_post.dart';
import 'package:danter/widgets/post_detail.dart';
import 'package:danter/widgets/time.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepliesScreen extends StatefulWidget {
  const RepliesScreen({
    super.key,
    required this.postEntity,
  });
  final PostEntity postEntity;

  @override
  State<RepliesScreen> createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  @override
  void dispose() {
    replyBloc.close();
    super.dispose();
  }

  final replyBloc = ReplyBloc(locator.get(), locator.get());

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider.value(
      value: replyBloc
        ..add(ReplyStartedEvent(
          postId: widget.postEntity.id,
        )),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danter'),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Divider(
                  height: 1,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  thickness: 0.7)),
        ),
        body: Stack(
          children: [
            BlocBuilder<ReplyBloc, ReplyState>(
              builder: (context, state) {
                if (state is ReplySuccesState) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: ThePostReply(
                          onTabReply: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: replyBloc,
                                child: WriteReply(
                                    postEntity: widget.postEntity,
                                    namePage: 'reply'),
                              ),
                            ));
                          },
                          postEntity: state.post[0],
                          onTabLike: () {
                            if (!state.post[0].likes
                                .contains(AuthRepository.readid())) {
                              BlocProvider.of<ReplyBloc>(context).add(
                                AddLikePostEvent(
                                  postId: state.post[0].id,
                                  user: AuthRepository.readid(),
                                ),
                              );
                            } else {
                              BlocProvider.of<ReplyBloc>(context).add(
                                RemoveLikePostEvent(
                                  postId: state.post[0].id,
                                  user: AuthRepository.readid(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SliverList.builder(
                        itemCount: state.reply.length,
                        itemBuilder: (context, index) {
                          return PostDetail(
                            onTabLike: () {
                              if (!state.reply[index].likes
                                  .contains(AuthRepository.readid())) {
                                BlocProvider.of<ReplyBloc>(context).add(
                                  AddLikeRplyEvent(
                                    postId: state.reply[index].id,
                                    user: AuthRepository.readid(),
                                  ),
                                );
                              } else {
                                BlocProvider.of<ReplyBloc>(context).add(
                                  RemoveLikeRplyEvent(
                                    postId: state.reply[index].id,
                                    user: AuthRepository.readid(),
                                  ),
                                );
                              }
                            },
                            onTabmore: () {},
                            postEntity: state.reply[index],
                          );
                        },
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 45))
                    ],
                  );
                } else if (state is ReplyLodingState) {
                  return Column(
                    children: [
                      ThePostReply(
                          onTabReply: () {},
                          postEntity: widget.postEntity,
                          onTabLike: () {}),
                      const Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: LightThemeColors.secondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is ReplyErrorState) {
                  return AppErrorWidget(
                    exception: state.exception,
                    onpressed: () {
                      // BlocProvider.of<ReplyBloc>(context)
                      //     .add(HomeRefreshEvent(user: AuthRepository.readid()));
                    },
                  );
                } else {
                  throw Exception('state is not supported ');
                }
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ReplyTo(
                  onTabNavigator: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: replyBloc,
                        child: WriteReply(
                            postEntity: widget.postEntity, namePage: 'reply'),
                      ),
                    ));
                  },
                  postEntity: widget.postEntity),
            )
          ],
        ),
      ),
    );
  }
}

class ReplyTo extends StatelessWidget {
  const ReplyTo({
    super.key,
    required this.postEntity,
    required this.onTabNavigator,
  });

  final PostEntity postEntity;
  final GestureTapCallback onTabNavigator;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      height: 55,
      color: themeData.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
              onTap: onTabNavigator,
              child: Container(
                color: themeData.colorScheme.onBackground, //Color(0xffF1A1A1A),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    (AuthRepository.loadAuthInfo()!.avatarchek.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                                height: 24,
                                width: 24,
                                child: ImageLodingService(
                                    imageUrl:
                                        AuthRepository.loadAuthInfo()!.avatar)),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                height: 24,
                                width: 24,
                                color: themeData.colorScheme.secondary,
                                child:
                                    Image.asset('assets/images/profile.png')),
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('Reply to ${postEntity.user.username}',
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class ThePostReply extends StatelessWidget {
  const ThePostReply({
    super.key,
    required this.postEntity,
    required this.onTabLike,
    required this.onTabReply,
  });

  final PostEntity postEntity;
  final GestureTapCallback onTabLike;
  final GestureTapCallback onTabReply;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Text(
                                postEntity.user.username,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const Spacer(),
                            TimePost(created: postEntity.created),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: Theme.of(context).colorScheme.onPrimary,
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
                      style: Theme.of(context).textTheme.titleMedium),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          ImagePost(postEntity: postEntity, leftpading: 10),
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
                    SizedBox(
                      height: (postEntity.replies.isNotEmpty ||
                              postEntity.likes.isNotEmpty)
                          ? 8
                          : 0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              const SizedBox(width: 18),
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

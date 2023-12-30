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
    return BlocProvider.value(
      value: replyBloc
        ..add(ReplyStartedEvent(
          postId: widget.postEntity.id,
        )),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Danter'), elevation: 0.5),
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
                      SliverPadding(padding: EdgeInsets.only(bottom: 60))
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
                                      color:
                                          LightThemeColors.secondaryTextColor,
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
    return Container(
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTabNavigator,
              child: Container(
                color: const Color(0xffF5F5F5),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
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
                                  height: 25,
                                  width: 25,
                                  child: ImageLodingService(
                                      imageUrl: AuthRepository.loadAuthInfo()!
                                          .avatar)),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: 25,
                                width: 25,
                                color: LightThemeColors.secondaryTextColor
                                    .withOpacity(0.4),
                                child: const Icon(
                                  CupertinoIcons.person_fill,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 8,
                      ),
                      Center(
                        child: Text(
                          'Reply to ${postEntity.user.username}',
                          style: const TextStyle(
                              color: Color(0xffA1A1A1),
                              fontSize: 15,
                            //  fontWeight: FontWeight.w100
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                            return BlocProvider(
                              create: (context) => ProfileBloc(locator.get()),
                              child: ProfileScreen(
                                  profileBloc: ProfileBloc(locator.get())),
                            );
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
                    padding: const EdgeInsets.only(left: 12),
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
                                        return BlocProvider(
                                          create: (context) =>
                                              ProfileBloc(locator.get()),
                                          child: ProfileScreen(
                                              profileBloc:
                                                  ProfileBloc(locator.get())),
                                        );
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
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            const Spacer(),
                            TimePost(created: postEntity.created),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: Colors.black87.withOpacity(0.8),
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
                  child: Text(
                    postEntity.text,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
        ImagePost(postEntity: postEntity , leftpading: 10),
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

                        LikeButton(postEntity: postEntity,onTabLike: onTabLike,),

                        const SizedBox(
                          width: 18,
                        ),
                        GestureDetector(
                          onTap: onTabReply,
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset(
                              'assets/images/comments.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: postEntity.replies.isNotEmpty,
                          child: Row(
                            children: [
                              Text(postEntity.replies.length.toString(),
                                  style: Theme.of(context).textTheme.subtitle1),
                              const SizedBox(width: 6),
                              Text(
                                  postEntity.replies.length <= 1
                                      ? 'reply'
                                      : 'replies',
                                  style: Theme.of(context).textTheme.subtitle1),
                              const SizedBox(width: 18),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: postEntity.likes.isNotEmpty,
                          child: Row(
                            children: [
                              Text(postEntity.likes.length.toString(),
                                  style: Theme.of(context).textTheme.subtitle1),
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
                                        Theme.of(context).textTheme.subtitle1),
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
          const Divider(
            color: Color(0xff999999),
            height: 20,
          ),
        ],
      ),
    );
  }
}

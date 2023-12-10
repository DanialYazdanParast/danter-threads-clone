import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/image/image_screen.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/screen/replies/bloc/reply_bloc.dart';
import 'package:danter/screen/replies/reply_list/replyList.dart';
import 'package:danter/screen/replies/write_reply/write_reply.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image.dart';
import 'package:danter/widgets/image_user_post.dart';
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
    return BlocProvider(
      create: (context) => replyBloc
        ..add(ReplyStartedEvent(
            postId: widget.postEntity.id, user: AuthRepository.readid())),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageUserPost(
                                      user: widget.postEntity.user,
                                      onTabNameUser: () {
                                        if (widget.postEntity.user.id ==
                                            AuthRepository.readid()) {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return BlocProvider(
                                                  create: (context) =>
                                                      ProfileBloc(
                                                          locator.get()),
                                                  child: const ProfileScreen(),
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ProfileUser(
                                                  user: widget.postEntity.user,
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (widget.postEntity.user
                                                            .id ==
                                                        AuthRepository
                                                            .readid()) {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return BlocProvider(
                                                              create: (context) =>
                                                                  ProfileBloc(
                                                                      locator
                                                                          .get()),
                                                              child:
                                                                  const ProfileScreen(),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    } else {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return ProfileUser(
                                                              user: widget
                                                                  .postEntity
                                                                  .user,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    widget.postEntity.user
                                                        .username,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                ),
                                                const Spacer(),
                                                TimePost(
                                                    created: widget
                                                        .postEntity.created),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.more_horiz,
                                                  color: Colors.black87
                                                      .withOpacity(0.8),
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
                              widget.postEntity.text != ''
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5, right: 10),
                                      child: Text(
                                        widget.postEntity.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              widget.postEntity.image.isNotEmpty &&
                                      widget.postEntity.image.length < 2
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10, bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(MaterialPageRoute(
                                            builder: (context) => ImageScreen(
                                              image:
                                                  'https://dan.chbk.run/api/files/6291brssbcd64k6/${widget.postEntity.id}/${widget.postEntity.image[0]}',
                                            ),
                                          ));
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: SizedBox(
                                              child: ImageLodingService(
                                                imageUrl:
                                                    'https://dan.chbk.run/api/files/6291brssbcd64k6/${widget.postEntity.id}/${widget.postEntity.image[0]}',
                                              ),
                                            )),
                                      ),
                                    )
                                  : widget.postEntity.image.length > 1
                                      ? SizedBox(
                                          height: 260,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                widget.postEntity.image.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      left: 10,
                                                      right: (index ==
                                                              widget
                                                                      .postEntity
                                                                      .image
                                                                      .length -
                                                                  1)
                                                          ? 10
                                                          : 0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ImageScreen(
                                                              image:
                                                                  'https://dan.chbk.run/api/files/6291brssbcd64k6/${widget.postEntity.id}/${widget.postEntity.image[index]}',
                                                            ),
                                                          ));
                                                        },
                                                        child:
                                                            ImageLodingService(
                                                          imageUrl:
                                                              'https://dan.chbk.run/api/files/6291brssbcd64k6/${widget.postEntity.id}/${widget.postEntity.image[index]}',
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                            },
                                          ),
                                        )
                                      : Container(),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                if (state.trueLikeUser == 0) {
                                                  await state.trueLikeUser++;

                                                  BlocProvider.of<ReplyBloc>(
                                                          context)
                                                      .add(
                                                    AddLikeReplyEvent(
                                                      postId:
                                                          widget.postEntity.id,
                                                      user: AuthRepository
                                                          .readid(),
                                                    ),
                                                  );
                                                } else {
                                                  await state.trueLikeUser--;
                                                  BlocProvider.of<ReplyBloc>(
                                                          context)
                                                      .add(
                                                    RemoveLikeReplyEvent(
                                                      postId:
                                                          widget.postEntity.id,
                                                      user: AuthRepository
                                                          .readid(),
                                                      likeId:
                                                          state.likeid[0].id,
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                child: state.trueLikeUser > 0
                                                    ? const Icon(
                                                        CupertinoIcons
                                                            .heart_fill,
                                                        color: Colors.red,
                                                        size: 24)
                                                    : const Icon(
                                                        CupertinoIcons.heart,
                                                        size: 24,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider.value(
                                                      value: replyBloc,
                                                      child: WriteReply(
                                                          postEntity: widget
                                                              .postEntity),
                                                    ),
                                                  ),
                                                );
                                              },
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
//-----------------------TextReplyAndLike----------------------//

                                            Text(state.totareplise.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                            const SizedBox(width: 6),
                                            Text(
                                                state.totareplise <= 1
                                                    ? 'reply'
                                                    : 'replies',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                            const SizedBox(width: 18),
                                            Text(state.totallike.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                            const SizedBox(width: 6),
                                            Text(
                                                state.totallike <= 1
                                                    ? 'Like'
                                                    : 'Likes',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
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
                        ),
                      ),
                      SliverList.builder(
                        itemCount: state.post.length,
                        itemBuilder: (context, index) {
                          return ReplayList(postEntity: state.post[index]);
                        },
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 60)),
                    ],
                  );
                } else if (state is ReplyLodingState) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state is ReplyErrorState) {
                  return AppErrorWidget(
                    exception: state.exception,
                    onpressed: () {},
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
              child: Container(
                  height: 55,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: replyBloc,
                              child: WriteReply(postEntity: widget.postEntity),
                            ),
                          ));
                        },
                        child: Container(
                          color: const Color(0xffF5F5F5),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                (AuthRepository.loadAuthInfo()!
                                        .avatarchek
                                        .isNotEmpty)
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: ImageLodingService(
                                                imageUrl: AuthRepository
                                                        .loadAuthInfo()!
                                                    .avatar)),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          color: LightThemeColors
                                              .secondaryTextColor
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
                                Text(
                                  'Reply to ${widget.postEntity.user.username}',
                                  style: const TextStyle(
                                      color: Color(0xffA1A1A1),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

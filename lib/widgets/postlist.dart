import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/di/di.dart';
import 'package:danter/screen/replies/replies_screen.dart';
import 'package:danter/screen/replies/write_reply/write_reply.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/bloc/post_bloc.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class PostList extends StatelessWidget {
  final PostEntity postEntity;
  const PostList({
    super.key,
    required this.postEntity,
  });

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now().difference(DateTime.parse(postEntity.created));

    var newFormat = DateFormat("yy-MM-dd");
    String updatedtime = newFormat.format(DateTime.parse(postEntity.created));
    int like = 0;
    int replise = 0;
    int likeuser = 0;

    // like = state.totallike;
    //                                     likeuser = state.trueLiseUser;
    //                                     replise = state.totareplise;
    return BlocProvider(
      create: (context) => PostBloc(locator.get())
        ..add(PostStartedEvent(
            postId: postEntity.id, user: AuthRepository.readid())),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => RepliesScreen(
              postEntity: postEntity,
              like: like,
              replies: replise,
            ),
          ));
        },
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostSuccesState) {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //ImageUserPost
                              ImageUserPost(postEntity: postEntity),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            postEntity.user.username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          const Spacer(),
                                          //TimePost
                                          TimePost(
                                              time: time,
                                              updatedtime: updatedtime),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.more_horiz,
                                            color:
                                                Colors.black87.withOpacity(0.8),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, right: 7),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              postEntity.text,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 65),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  state.trueLiseUser == 0
                                      ? BlocProvider.of<PostBloc>(context).add(
                                          AddLikePostEvent(
                                              postId: postEntity.id,
                                              user: AuthRepository.readid()))
                                      : BlocProvider.of<PostBloc>(context).add(
                                          RemoveLikePostEvent(
                                              postId: postEntity.id,
                                              user: AuthRepository.readid(),
                                              likeId: state.likeid[0].id));
                                },
                                child: Container(
                                  child: state.trueLiseUser > 0
                                      ? const Icon(CupertinoIcons.heart_fill,
                                          color: Colors.red, size: 24)
                                      : const Icon(CupertinoIcons.heart,
                                          size: 24),
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              GestureDetector(
                                // onTap: () {
                                //   Navigator.of(context,
                                //           rootNavigator: true)
                                //       .push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         WriteReply(),
                                //   ));
                                // },
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ////////////////////////

                                state.totareplise > 1
                                    ? Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ClipRRect(
                                              child: Container(
                                            width: 22,
                                            height: 22,
                                            child: (state.totareplisePhoto[0]
                                                    .user.avatarchek.isNotEmpty)
                                                ? Container(
                                                    height: 22,
                                                    width: 22,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                Colors.white)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: ImageLodingService(
                                                          imageUrl: state
                                                              .totareplisePhoto[
                                                                  0]
                                                              .user
                                                              .avatar),
                                                    ))
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: LightThemeColors
                                                              .secondaryTextColor
                                                              .withOpacity(0.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Colors
                                                                  .white)),
                                                      child: const Icon(
                                                        CupertinoIcons
                                                            .person_fill,
                                                        color: Colors.white,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                          )),
                                          Positioned(
                                            left: 13,
                                            bottom: 0,
                                            child: Container(
                                              width: 22,
                                              height: 22,
                                              child: (state
                                                      .totareplisePhoto[1]
                                                      .user
                                                      .avatarchek
                                                      .isNotEmpty)
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Container(
                                                          height: 22,
                                                          width: 22,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .white)),
                                                          child: ImageLodingService(
                                                              imageUrl: state
                                                                  .totareplisePhoto[
                                                                      1]
                                                                  .user
                                                                  .avatar)),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            color: LightThemeColors
                                                                .secondaryTextColor
                                                                .withOpacity(
                                                                    0.4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                                width: 2,
                                                                color: Colors
                                                                    .white)),
                                                        child: const Icon(
                                                          CupertinoIcons
                                                              .person_fill,
                                                          color: Colors.white,
                                                          size: 22,
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          )
                                        ],
                                      )
                                    : state.totareplise == 1
                                        ? Container(
                                            width: 22,
                                            height: 22,
                                            margin: EdgeInsets.only(left: 8),
                                            child: (state.totareplisePhoto[0]
                                                    .user.avatarchek.isNotEmpty)
                                                ? Container(
                                                    height: 22,
                                                    width: 22,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                Colors.white)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: ImageLodingService(
                                                          imageUrl: state
                                                              .totareplisePhoto[
                                                                  0]
                                                              .user
                                                              .avatar),
                                                    ))
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: LightThemeColors
                                                              .secondaryTextColor
                                                              .withOpacity(0.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Colors
                                                                  .white)),
                                                      child: const Icon(
                                                        CupertinoIcons
                                                            .person_fill,
                                                        color: Colors.white,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(left: 30),
                                          ),

                                //////////////

                                SizedBox(
                                    width: state.totareplise > 1 ? 30 : 22),

                                Text(
                                  state.totareplise.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  state.totareplise <= 1 ? 'reply' : 'replies',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  state.totallike.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  state.totallike <= 1 ? 'Like' : 'Likes',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ]),
                        ),
                        const Divider(
                          // color: Color(0xff999999),
                          height: 20,
                          //thickness: 0.4,
                        ),
                      ],
                    ),
                    Positioned(
                        left: 33,
                        top: 75,
                        bottom: 54,
                        child: Container(
                          width: state.totareplise > 0 ? 1 : 0,
                          color: LightThemeColors.secondaryTextColor,
                        )),
                  ],
                ),
              );
            } else if (state is PostInitial) {
              return Container();
            } else if (state is PostErrorState) {
              return Text(
                'error',
                style: Theme.of(context).textTheme.subtitle1,
              );
            } else {
              throw Exception('state is not supported ');
            }
          },
        ),
      ),
    );
  }
}

class TimePost extends StatelessWidget {
  const TimePost({
    super.key,
    required this.time,
    required this.updatedtime,
  });

  final Duration time;
  final String updatedtime;

  @override
  Widget build(BuildContext context) {
    return Text(
      time.inMinutes == 0
          ? 'Now'
          : time.inMinutes < 60
              ? '${time.inMinutes}m'
              : time.inHours < 24
                  ? '${time.inHours}h'
                  : time.inDays < 8
                      ? '${time.inDays}d'
                      : time.inDays >= 8
                          ? '${updatedtime}'
                          : '',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}

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

// else if (state is PostInitial) {
//                                         return Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 '0',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle1,
//                                               ),
//                                               const SizedBox(
//                                                 width: 6,
//                                               ),
//                                               Text(
//                                                 'reply',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle1,
//                                               ),
//                                               const SizedBox(
//                                                 width: 18,
//                                               ),
//                                               Text(
//                                                 '0',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle1,
//                                               ),
//                                               const SizedBox(
//                                                 width: 6,
//                                               ),
//                                               Text(
//                                                 'Like',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle1,
//                                               ),
//                                             ]);
//                                       } else if (state is PostErrorState) {
//                                         return Text(
//                                           'error',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .subtitle1,
//                                         );
//                                       } else {
//                                         throw Exception(
//                                             'state is not supported ');
//                                       }
//                                     },

// BlocBuilder<PostBloc, PostState>(
//   builder: (context, state) {
//     if (state is PostSuccesState) {
//       return 
//     } else if (state is PostInitial) {
//       return Container();
//     } else if (state is PostErrorState) {
//       return Text(
//         'error',
//         style: Theme.of(context).textTheme.subtitle1,
//       );
//     } else {
//       throw Exception('state is not supported ');
//     }
//   },
// ),

import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/di/di.dart';
import 'package:danter/screen/replies/replies_screen.dart';

import 'package:danter/theme.dart';
import 'package:danter/widgets/bloc/post_bloc.dart';
import 'package:danter/widgets/image.dart';
import 'package:danter/widgets/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatelessWidget {
  final PostEntity postEntity;
  const PostList({
    super.key,
    required this.postEntity,
  });

  @override
  Widget build(BuildContext context) {
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
                      children: [
                        ImageAndNameAndText(postEntity: postEntity),
                        Padding(
                          padding: const EdgeInsets.only(left: 65),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (state.trueLiseUser == 0) {
                                    await state.trueLiseUser++;

                                    BlocProvider.of<PostBloc>(context).add(
                                      AddLikePostEvent(
                                        postId: postEntity.id,
                                        user: AuthRepository.readid(),
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<PostBloc>(context).add(
                                      RemoveLikePostEvent(
                                        postId: postEntity.id,
                                        user: AuthRepository.readid(),
                                        likeId: state.likeid[0].id,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  child: state.trueLiseUser > 0
                                      ? const Icon(CupertinoIcons.heart_fill,
                                          color: Colors.red, size: 24)
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

                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //-----------------------ImageReply----------------------//

                              state.totareplise > 1
                                  ? Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        (state.totareplisePhoto[0].user
                                                .avatarchek.isNotEmpty)
                                            ? ImageReplyUser(
                                                photo: state.totareplisePhoto[0]
                                                    .user.avatar,
                                              )
                                            : const PhotoReplyUserNoPhoto(),
                                        Positioned(
                                          left: 13,
                                          bottom: 0,
                                          child: (state.totareplisePhoto[1].user
                                                  .avatarchek.isNotEmpty)
                                              ? ImageReplyUser(
                                                  photo: state
                                                      .totareplisePhoto[1]
                                                      .user
                                                      .avatar,
                                                )
                                              : const PhotoReplyUserNoPhoto(),
                                        )
                                      ],
                                    )
                                  : state.totareplise == 1
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          child: (state.totareplisePhoto[0].user
                                                  .avatarchek.isNotEmpty)
                                              ? ImageReplyUser(
                                                  photo: state
                                                      .totareplisePhoto[0]
                                                      .user
                                                      .avatar,
                                                )
                                              : const PhotoReplyUserNoPhoto(),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(left: 30),
                                        ),

                              //-----------------------ImageReply----------------------//
//-----------------------TextReplyAndLike----------------------//
                              SizedBox(width: state.totareplise > 1 ? 30 : 22),

                              Text(state.totareplise.toString(),
                                  style: Theme.of(context).textTheme.subtitle1),
                              const SizedBox(width: 6),
                              Text(state.totareplise <= 1 ? 'reply' : 'replies',
                                  style: Theme.of(context).textTheme.subtitle1),
                              const SizedBox(width: 18),
                              Text(state.totallike.toString(),
                                  style: Theme.of(context).textTheme.subtitle1),
                              const SizedBox(width: 6),
                              Text(state.totallike <= 1 ? 'Like' : 'Likes',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                        ),
//-----------------------TextReplyAndLike----------------------//
                        const Divider(height: 20),
                      ],
                    ),
                    //----------LineReply-----------//
                    Positioned(
                      left: 33,
                      top: 75,
                      bottom: 54,
                      child: Container(
                        width: state.totareplise > 0 ? 1 : 0,
                        color: LightThemeColors.secondaryTextColor,
                      ),
                    ),
//----------LineReply-----------//
                  ],
                ),
              );
            } else if (state is PostInitial) {
              return InitState(postEntity: postEntity);
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

class InitState extends StatelessWidget {
  const InitState({
    super.key,
    required this.postEntity,
  });

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          ImageAndNameAndText(postEntity: postEntity),
          Padding(
            padding: const EdgeInsets.only(left: 65),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.heart,
                  size: 24,
                ),
                const SizedBox(
                  width: 18,
                ),
                SizedBox(
                  height: 22,
                  width: 22,
                  child: Image.asset(
                    'assets/images/comments.png',
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 67, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('0',
                    style: Theme.of(context).textTheme.subtitle1),
                const SizedBox(width: 6),
                Text('reply',
                    style: Theme.of(context).textTheme.subtitle1),
                const SizedBox(width: 18),
                Text('0',
                    style: Theme.of(context).textTheme.subtitle1),
                const SizedBox(width: 6),
                Text('Like',
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          const Divider(height: 20),
        ],
      ),
    );
  }
}

class ImageAndNameAndText extends StatelessWidget {
  const ImageAndNameAndText({
    super.key,
    required this.postEntity,
  });

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //----------------------ImageUserPost----------------------//
          ImageUserPost(postEntity: postEntity),
          //----------------------ImageUserPost----------------------//

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        postEntity.user.username,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Spacer(),
                      //TimePost
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
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 7),
                    child: Text(
                      postEntity.text,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageReplyUser extends StatelessWidget {
  const ImageReplyUser({
    super.key,
    required this.photo,
  });

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
      ),
      child: ImageLodingService(
        borderRadius: BorderRadius.circular(
          100,
        ),
        imageUrl: photo,
      ),
    );
  }
}

class PhotoReplyUserNoPhoto extends StatelessWidget {
  const PhotoReplyUserNoPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
          color: LightThemeColors.secondaryTextColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: Colors.white)),
      child: const Icon(
        CupertinoIcons.person_fill,
        color: Colors.white,
        size: 22,
      ),
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
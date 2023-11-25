import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/replies/bloc/reply_bloc.dart';
import 'package:danter/screen/replies/reply_list/replyList.dart';
import 'package:danter/screen/replies/write_reply/write_reply.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RepliesScreen extends StatelessWidget {
  const RepliesScreen(
      {super.key,
      required this.postEntity,
      required this.like,
      required this.replies});
  final PostEntity postEntity;
  final int like;
  final int replies;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReplyBloc(locator.get())
        ..add(ReplyStartedEvent(postI: postEntity.id)),
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
                        child: ReplyPost(
                            postEntity: postEntity,
                            like: like,
                            replies: replies),
                      ),
                      SliverList.builder(
                        itemCount: state.post.length,
                        itemBuilder: (context, index) {
                          return ReplayList(replyEntity: state.post[index]);
                        },
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 60))
                    ],
                  );
                } else if (state is ReplyLodingState) {
                  return Center(child: CupertinoActivityIndicator());
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
                            builder: (context) => WriteReply(postEntity: postEntity),
                          ));
                        },
                        child: Container(
                          color: const Color(0xffF5F5F5),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
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
                                  'Reply to ${postEntity.user.username}',
                                  style: TextStyle(
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

//-----------ReplyPost-------------//
class ReplyPost extends StatelessWidget {
  const ReplyPost({
    super.key,
    required this.postEntity,
    required this.like,
    required this.replies,
  });
  final PostEntity postEntity;
  final int like;
  final int replies;

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now().difference(DateTime.parse(postEntity.created));

    var newFormat = DateFormat("yy-MM-dd");
    String updatedtime = newFormat.format(DateTime.parse(postEntity.created));

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
                (postEntity.user.avatarchek.isNotEmpty)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                            height: 47,
                            width: 47,
                            child: ImageLodingService(
                                imageUrl: postEntity.user.avatar)),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 47,
                          width: 47,
                          color: LightThemeColors.secondaryTextColor
                              .withOpacity(0.4),
                          child: const Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.white,
                            size: 55,
                          ),
                        ),
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
                            Text(
                              postEntity.user.username,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const Spacer(),
                            Text(
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
                            ),
                            const SizedBox(
                              width: 20,
                            ),

                            Icon(
                              Icons.more_horiz,
                              color: Colors.black87.withOpacity(0.8),
                            )
                            // Text('---',
                            //     style: Theme.of(context).textTheme.subtitle2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postEntity.text,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.heart, size: 24),
                    const SizedBox(
                      width: 18,
                    ),
                    GestureDetector(
                      // onTap: () {
                      //   Navigator.of(context, rootNavigator: true)
                      //       .push(MaterialPageRoute(
                      //     builder: (context) => WriteReply(),
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      replies.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      'replies',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      like.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      'likes',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                )
              ],
            ),
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

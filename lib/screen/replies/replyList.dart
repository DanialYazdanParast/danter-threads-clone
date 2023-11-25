import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/reply.dart';

import 'package:danter/di/di.dart';
import 'package:danter/screen/replies/replies_screen.dart';
import 'package:danter/screen/replies/write_reply.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/bloc/post_bloc.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class ReplayList extends StatelessWidget {
  final RplyEntity postEntity;
  const ReplayList({
    super.key,
    required this.postEntity,
  });

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now().difference(DateTime.parse(postEntity.created));

    var newFormat = DateFormat("yy-MM-dd");
    String updatedtime = newFormat.format(DateTime.parse(postEntity.created));
    int like = 0;
    int replise= 0;
    return 
    // BlocProvider(
    //   create: (context) =>
    //       PostBloc(locator.get())..add(PostStartedEvent(postId: postEntity.id)),
    //   child:
       GestureDetector(
        onTap: () {
          // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          //   builder: (context) => RepliesScreen(
          //     postEntity: postEntity,
          //     like: like,
          //     replies: replise,
          //   ),
          // ));
        },
        child: Container(
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style:
                                          Theme.of(context).textTheme.headline6,
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
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.more_horiz,
                                      color: Colors.black87.withOpacity(0.8),
                                    )
                                    // Text('---',
                                    //     style: Theme.of(context).textTheme.subtitle2),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 7),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        postEntity.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(CupertinoIcons.heart,
                                              size: 24),
                                          const SizedBox(
                                            width: 18,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    WriteReply(),
                                              ));
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
                                      // BlocBuilder<PostBloc, PostState>(
                                      //   builder: (context, state) {
                                      //     if (state is PostSuccesState) {
                                      //       like = state.totallike;
                                      //       replise = state.totareplise;
                                      //       return Row(
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.start,
                                      //           children: [
                                      //             Text(
                                      //               state.totareplise
                                      //                   .toString(),
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .subtitle1,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 6,
                                      //             ),
                                      //             Text(
                                      //               state.totareplise <= 1
                                      //                   ? 'reply'
                                      //                   : 'replies',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .subtitle1,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 18,
                                      //             ),
                                      //             Text(
                                      //               state.totallike.toString(),
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .subtitle1,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 6,
                                      //             ),
                                      //             Text(
                                      //               state.totallike <= 1
                                      //                   ? 'Like'
                                      //                   : 'Likes',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .subtitle1,
                                      //             ),
                                      //           ]);
                                      //     } else if (state is PostInitial) {
                                      //       return Row(
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.start,
                                      //           children: [
                                      //             Text(
                                      //               '0',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .subtitle1,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 6,
                                      //             ),
                                      //             Text(
                                      //               'reply',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .subtitle1,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 18,
                                      //             ),
                                      //             Text(
                                      //               '0',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .subtitle1,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 6,
                                      //             ),
                                      //             Text(
                                      //               'Like',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .subtitle1,
                                      //             ),
                                      //           ]);
                                      //     } else if (state is PostErrorState) {
                                      //       return Text(
                                      //         'error',
                                      //         style: Theme.of(context)
                                      //             .textTheme
                                      //             .subtitle1,
                                      //       );
                                      //     } else {
                                      //       throw Exception(
                                      //           'state is not supported ');
                                      //     }
                                      //   },
                                      // ),
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
                  const Divider(
                    // color: Color(0xff999999),
                    height: 20,
//thickness: 0.4,
                  ),
                ],
              ),
              // BlocBuilder<PostBloc, PostState>(
              //   builder: (context, state) {
              //     if (state is PostSuccesState) {
              //       return Positioned(
              //           left: 33,
              //           top: 75,
              //           bottom: 54,
              //           child: Container(
              //             width: state.totareplise > 0 ? 1 : 0,
              //             color: LightThemeColors.secondaryTextColor,
              //           ));
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
              // BlocBuilder<PostBloc, PostState>(
              //   builder: (context, state) {
              //     if (state is PostSuccesState) {
              //       return Positioned(
              //           left: 17,
              //           bottom: 22,
              //           child: state.totareplise > 1
              //               ? Stack(
              //                   clipBehavior: Clip.none,
              //                   children: [
              //                     ClipRRect(
              //                         child: Container(
              //                       width: 22,
              //                       height: 22,
              //                       child: (state.totareplisePhoto[0].user
              //                               .avatarchek.isNotEmpty)
              //                           ? Container(
              //                               height: 22,
              //                               width: 22,
              //                               decoration: BoxDecoration(
              //                                   borderRadius:
              //                                       BorderRadius.circular(50),
              //                                   border: Border.all(
              //                                       width: 2,
              //                                       color: Colors.white)),
              //                               child: ClipRRect(
              //                                 borderRadius:
              //                                     BorderRadius.circular(100),
              //                                 child: ImageLodingService(
              //                                     imageUrl: state
              //                                         .totareplisePhoto[0]
              //                                         .user
              //                                         .avatar),
              //                               ))
              //                           : ClipRRect(
              //                               borderRadius:
              //                                   BorderRadius.circular(100),
              //                               child: Container(
              //                                 height: 22,
              //                                 width: 22,
              //                                 color: LightThemeColors
              //                                     .secondaryTextColor
              //                                     .withOpacity(0.4),
              //                                 child: const Icon(
              //                                   CupertinoIcons.person_fill,
              //                                   color: Colors.white,
              //                                   size: 10,
              //                                 ),
              //                               ),
              //                             ),
              //                     )),
              //                     Positioned(
              //                       left: 13,
              //                       bottom: 0,
              //                       child: Container(
              //                         width: 22,
              //                         height: 22,
              //                         child: (state.totareplisePhoto[1].user
              //                                 .avatarchek.isNotEmpty)
              //                             ? ClipRRect(
              //                                 borderRadius:
              //                                     BorderRadius.circular(100),
              //                                 child: Container(
              //                                     height: 22,
              //                                     width: 22,
              //                                     decoration: BoxDecoration(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 50),
              //                                         border: Border.all(
              //                                             width: 2,
              //                                             color: Colors.white)),
              //                                     child: ImageLodingService(
              //                                         imageUrl: state
              //                                             .totareplisePhoto[1]
              //                                             .user
              //                                             .avatar)),
              //                               )
              //                             : ClipRRect(
              //                                 borderRadius:
              //                                     BorderRadius.circular(100),
              //                                 child: Container(
              //                                   height: 25,
              //                                   width: 25,
              //                                   decoration: BoxDecoration(
              //                                       color: LightThemeColors
              //                                           .secondaryTextColor,
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               50),
              //                                       border: Border.all(
              //                                           width: 2,
              //                                           color: Colors.white)),
              //                                   child: const Icon(
              //                                     CupertinoIcons.person_fill,
              //                                     color: Colors.white,
              //                                     size: 25,
              //                                   ),
              //                                 ),
              //                               ),
              //                       ),
              //                     )
              //                   ],
              //                 )
              //               : state.totareplise == 1
              //                   ? Positioned(
              //                       left: 22,
              //                       bottom: 22,
              //                       child: Container(
              //                         width: 22,
              //                         height: 22,
              //                         child: (state.totareplisePhoto[0].user
              //                                 .avatarchek.isNotEmpty)
              //                             ? Container(
              //                                 height: 22,
              //                                 width: 22,
              //                                 decoration: BoxDecoration(
              //                                     borderRadius:
              //                                         BorderRadius.circular(50),
              //                                     border: Border.all(
              //                                         width: 2,
              //                                         color: Colors.white)),
              //                                 child: ClipRRect(
              //                                   borderRadius:
              //                                       BorderRadius.circular(100),
              //                                   child: ImageLodingService(
              //                                       imageUrl: state
              //                                           .totareplisePhoto[0]
              //                                           .user
              //                                           .avatar),
              //                                 ))
              //                             : ClipRRect(
              //                                 borderRadius:
              //                                     BorderRadius.circular(100),
              //                                 child: Container(
              //                                   height: 25,
              //                                   width: 25,
              //                                   decoration: BoxDecoration(
              //                                       color: LightThemeColors
              //                                           .secondaryTextColor,
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               50),
              //                                       border: Border.all(
              //                                           width: 2,
              //                                           color: Colors.white)),
              //                                   child: const Icon(
              //                                     CupertinoIcons.person_fill,
              //                                     color: Colors.white,
              //                                     size: 25,
              //                                   ),
              //                                 ),
              //                               ),
              //                       ),
              //                     )
              //                   : Container());
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
            ],
          ),
        ),
    //  ),
    );
  }
}

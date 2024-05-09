import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/replies/bloc/reply_bloc.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/core/widgets/post_detail.dart';
import 'package:danter/screen/replies/widgets/reply_to.dart';
import 'package:danter/screen/replies/widgets/the_post_reply.dart';
import 'package:danter/screen/write_reply/screens/write_reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepliesScreen extends StatefulWidget {
  const RepliesScreen({
    super.key,
    required this.postEntity,
    required this.pagename,
  });
  final PostEntity postEntity;
  final String pagename;

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
              builder: (context2, state) {
                if (state is ReplySuccesState) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: ThePostReply(
                          pagename: widget.pagename,
                          context2: context2,
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
                              BlocProvider.of<ReplyBloc>(context2).add(
                                AddLikePostEvent(
                                  postId: state.post[0].id,
                                  user: AuthRepository.readid(),
                                ),
                              );
                            } else {
                              BlocProvider.of<ReplyBloc>(context2).add(
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
                            namepage: widget.pagename,
                            onTabLike: () {
                              if (!state.reply[index].likes
                                  .contains(AuthRepository.readid())) {
                                BlocProvider.of<ReplyBloc>(context2).add(
                                  AddLikeRplyEvent(
                                    postId: state.reply[index].id,
                                    user: AuthRepository.readid(),
                                  ),
                                );
                              } else {
                                BlocProvider.of<ReplyBloc>(context2).add(
                                  RemoveLikeRplyEvent(
                                    postId: state.reply[index].id,
                                    user: AuthRepository.readid(),
                                  ),
                                );
                              }
                            },
                            onTabmore: () {
                              if (state.reply[index].user.id ==
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
                                                    title: "Delete this Post?",
                                                    description: "",
                                                    onTabRemove: () {
                                                      BlocProvider.of<
                                                                  ReplyBloc>(
                                                              context2)
                                                          .add(DeletRplyEvent(
                                                              postid: state
                                                                  .reply[index]
                                                                  .id));

                                                      Navigator.pop(context);

                                                      Navigator.pop(context3);

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        snackBarApp(
                                                            themeData,
                                                            'با موفقیت حذف شد',
                                                            5),
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
                                                  color: themeData
                                                      .colorScheme.onBackground,
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
                          pagename: widget.pagename,
                          context2: context2,
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
                  return Column(
                    children: [
                      ThePostReply(
                          pagename: widget.pagename,
                          context2: context2,
                          onTabReply: () {},
                          postEntity: widget.postEntity,
                          onTabLike: () {}),
                      const SizedBox(
                        height: 20,
                      ),
                      AppErrorWidget(
                        exception: state.exception,
                        onpressed: () {
                          BlocProvider.of<ReplyBloc>(context2)
                              .add(ReplyRefreshEvent(
                            postId: widget.postEntity.id,
                          ));
                        },
                      )
                    ],
                  );
                } else if (state is ReplySuccesStateDelet) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Center(
                            child: Text('Content not available',
                                style: Theme.of(context).textTheme.titleSmall)),
                      ),
                      Divider(
                          height: 20,
                          color:
                              themeData.colorScheme.secondary.withOpacity(0.5),
                          thickness: 0.7),
                    ],
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

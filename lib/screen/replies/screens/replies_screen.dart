import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/widgets/bottom_sheet_custom.dart';
import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/likes/bloc/likes_bloc.dart';
import 'package:danter/screen/likes/screens/likes_screen.dart';
import 'package:danter/screen/replies/bloc/reply_bloc.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/core/widgets/post_detail.dart';
import 'package:danter/screen/replies/widgets/app_bar_replies.dart';
import 'package:danter/screen/replies/widgets/reply_to.dart';
import 'package:danter/screen/replies/widgets/the_post_reply.dart';
import 'package:danter/screen/root/screens/root.dart';
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
    _controller.dispose();
    super.dispose();
  }

  final replyBloc = ReplyBloc(locator.get(), locator.get());
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider.value(
      value: replyBloc
        ..add(ReplyStartedEvent(
          postId: widget.postEntity.id,
        )),
      child: Padding(
        padding: EdgeInsets.only(top: !RootScreen.isMobile(context) ? 20 : 0),
        child: Scaffold(
          body: Scrollbar(
            controller: _controller,
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      BlocBuilder<ReplyBloc, ReplyState>(
                        builder: (context2, state) {
                          if (state is ReplySuccesState) {
                            return ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: CustomScrollView(
                                controller: _controller,
                                slivers: [
                                  const AppBarReplies(),
                                  SliverToBoxAdapter(
                                    child: ThePostReply(
                                      pagename: widget.pagename,
                                      context2: context2,
                                      onTabReply: () {
                                        Navigator.of(context,
                                                rootNavigator:
                                                    RootScreen.isMobile(context)
                                                        ? true
                                                        : false)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider.value(
                                            value: replyBloc,
                                            child: WriteReply(
                                                postEntity: widget.postEntity,
                                                namePage: 'reply'),
                                          ),
                                        ));
                                      },
                                      postEntity: state.post[0],
                                      onTabLike: () {
                                        if (!state.post[0].likes.contains(
                                            AuthRepository.readid())) {
                                          BlocProvider.of<ReplyBloc>(context2)
                                              .add(
                                            AddLikePostEvent(
                                              postId: state.post[0].id,
                                              user: AuthRepository.readid(),
                                            ),
                                          );
                                        } else {
                                          BlocProvider.of<ReplyBloc>(context2)
                                              .add(
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
                                              .contains(
                                                  AuthRepository.readid())) {
                                            BlocProvider.of<ReplyBloc>(context2)
                                                .add(
                                              AddLikeRplyEvent(
                                                postId: state.reply[index].id,
                                                user: AuthRepository.readid(),
                                              ),
                                            );
                                          } else {
                                            BlocProvider.of<ReplyBloc>(context2)
                                                .add(
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
                                              backgroundColor: themeData
                                                  .scaffoldBackgroundColor,
                                              //  showDragHandle: true,
                                              elevation: 0,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                              builder: (context3) {
                                                return BottomSheetCustom(
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
                                                              .add(DeletRplyEvent(
                                                                  postid: state
                                                                      .reply[
                                                                          index]
                                                                      .id));

                                                          Navigator.pop(
                                                              context);

                                                          Navigator.pop(
                                                              context3);

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            snackBarApp(
                                                                themeData,
                                                                'با موفقیت حذف شد',
                                                                5,
                                                                context),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                });
                                              },
                                            );
                                          }
                                        },
                                        postEntity: state.reply[index],
                                      );
                                    },
                                  ),
                                  const SliverPadding(
                                      padding: EdgeInsets.only(bottom: 45))
                                ],
                              ),
                            );
                          } else if (state is ReplyLodingState) {
                            return CustomScrollView(
                              slivers: [
                                const AppBarReplies(),
                                SliverToBoxAdapter(
                                  child: ThePostReply(
                                      pagename: widget.pagename,
                                      context2: context2,
                                      onTabReply: () {},
                                      postEntity: widget.postEntity,
                                      onTabLike: () {}),
                                ),
                                const SliverToBoxAdapter(
                                  child: Center(
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
                                ),
                              ],
                            );
                          } else if (state is ReplyErrorState) {
                            return CustomScrollView(
                              slivers: [
                                const AppBarReplies(),
                                SliverToBoxAdapter(
                                  child: ThePostReply(
                                      pagename: widget.pagename,
                                      context2: context2,
                                      onTabReply: () {},
                                      postEntity: widget.postEntity,
                                      onTabLike: () {}),
                                ),
                                const SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: 20,
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: AppErrorWidget(
                                    exception: state.exception,
                                    onpressed: () {
                                      BlocProvider.of<ReplyBloc>(context2)
                                          .add(ReplyRefreshEvent(
                                        postId: widget.postEntity.id,
                                      ));
                                    },
                                  ),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall)),
                                ),
                                Divider(
                                    height: 20,
                                    color: themeData.colorScheme.secondary
                                        .withOpacity(0.5),
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
                              Navigator.of(context,
                                      rootNavigator:
                                          RootScreen.isMobile(context)
                                              ? true
                                              : false)
                                  .push(MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: replyBloc,
                                  child: WriteReply(
                                      postEntity: widget.postEntity,
                                      namePage: 'reply'),
                                ),
                              ));
                            },
                            postEntity: widget.postEntity),
                      )
                    ],
                  ),
                ),
                Visibility(
                    visible: !RootScreen.isMobile(context),
                    child: const VerticalDivider()),
                Visibility(
                  visible: !RootScreen.isMobile(context),
                  child: SizedBox(
                      width: 350,
                      child: BlocConsumer<ReplyBloc, ReplyState>(
                        listener: (context, state) {
                          if (state is ReplyAddAndRemoveLike) {
                            BlocProvider.of<LikesBloc>(context).add(
                                LikesRefreshEvent(
                                    postId: widget.postEntity.id));
                          }
                        },
                        buildWhen: (previous, current) {
                          return current is ReplyAddAndRemoveLike;
                        },
                        builder: (context, state) {
                          return LikesScreen(
                            idpostEntity: widget.postEntity.id,
                            namePage: 'RepliesScreen',
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

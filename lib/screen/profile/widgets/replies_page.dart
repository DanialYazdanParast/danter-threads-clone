import 'package:danter/core/widgets/bottom_sheet_custom.dart';
import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/replies_detail.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepliesPage extends StatelessWidget {
  final List<PostReply> reply;
  final BuildContext context2;
  const RepliesPage({
    super.key,
    required this.reply,
    required this.context2,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: reply.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  right: !RootScreen.isMobile(context) ? 10 : 0),
              child: RepliseDtaile(
                namepage: 'ProfileScreenReply',
                onTabLikeMyReply: () {
                  if (!reply[index]
                      .myReply
                      .likes
                      .contains(AuthRepository.readid())) {
                    BlocProvider.of<ProfileBloc>(context).add(
                      AddLikeMyReplyProfileEvent(
                        postId: reply[index].myReply.id,
                        user: AuthRepository.readid(),
                      ),
                    );
                  } else {
                    BlocProvider.of<ProfileBloc>(context).add(
                      RemoveLikeMyReplyProfileEvent(
                        postId: reply[index].myReply.id,
                        user: AuthRepository.readid(),
                      ),
                    );
                  }
                },
                onTabLikeReplyTo: () {
                  if (!reply[index]
                      .replyTo
                      .likes
                      .contains(AuthRepository.readid())) {
                    BlocProvider.of<ProfileBloc>(context).add(
                      AddLikeReplyToProfileEvent(
                        postId: reply[index].replyTo.id,
                        user: AuthRepository.readid(),
                      ),
                    );
                  } else {
                    BlocProvider.of<ProfileBloc>(context).add(
                      RemoveLikeReplyToProfileEvent(
                        postId: reply[index].replyTo.id,
                        user: AuthRepository.readid(),
                      ),
                    );
                  }
                },
                postEntity: reply[index],
                onTabNameUser: () {},
                onTabmore: () {
                  showModalBottomSheet(
                    barrierColor:
                        themeData.colorScheme.onSecondary.withOpacity(0.1),
                    context: context,
                    useRootNavigator: true,
                    backgroundColor: themeData.scaffoldBackgroundColor,
                    //  showDragHandle: true,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context3) {
                      return BottomSheetCustom(onTap: () {
                        showDialog(
                          useRootNavigator: true,
                          barrierDismissible: false,
                          barrierColor: themeData.colorScheme.onSecondary
                              .withOpacity(0.1),
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                              button: 'Delete',
                              title: "Delete this Post?",
                              description: "",
                              onTabRemove: () {
                                BlocProvider.of<ProfileBloc>(context2).add(
                                    ProfiledeletPostEvent(
                                        user: AuthRepository.readid(),
                                        postid: reply[index].myReply.id));

                                Navigator.pop(context);

                                Navigator.pop(context3);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarApp(themeData, 'با موفقیت حذف شد', 5,
                                      context),
                                );
                              },
                            );
                          },
                        );
                      });
                    },
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}

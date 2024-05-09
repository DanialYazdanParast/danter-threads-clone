import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/replies_detail.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
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
            return RepliseDtaile(
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
                              color: themeData.colorScheme.secondary,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 24),
                          child: InkWell(
                            onTap: () {
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
                                      BlocProvider.of<ProfileBloc>(context2)
                                          .add(ProfiledeletPostEvent(
                                              user: AuthRepository.readid(),
                                              postid: reply[index].myReply.id));

                                      Navigator.pop(context);

                                      Navigator.pop(context3);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        snackBarApp(
                                            themeData, 'با موفقیت حذف شد', 5),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: themeData.colorScheme.onBackground,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
              },
            );
          },
        )
      ],
    );
  }
}

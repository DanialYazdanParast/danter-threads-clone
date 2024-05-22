import 'package:danter/core/widgets/bottom_sheet_custom.dart';
import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/post_detail.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanterPage extends StatelessWidget {
  final List<PostEntity> post;
  final BuildContext context2;

  const DanterPage({
    super.key,
    required this.post,
    required this.context2,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CustomScrollView(
      slivers: [
        (post.isNotEmpty)
            ? SliverList.builder(
                itemCount: post.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: !RootScreen.isMobile(context) ? 10 : 0),
                    child: PostDetail(
                      namepage: 'ProfileScreen',
                      onTabLike: () {
                        if (!post[index]
                            .likes
                            .contains(AuthRepository.readid())) {
                          BlocProvider.of<ProfileBloc>(context).add(
                            AddLikeProfileEvent(
                              postId: post[index].id,
                              user: AuthRepository.readid(),
                            ),
                          );
                        } else {
                          BlocProvider.of<ProfileBloc>(context).add(
                            RemoveLikeProfileEvent(
                              postId: post[index].id,
                              user: AuthRepository.readid(),
                            ),
                          );
                        }
                      },
                      postEntity: post[index],
                      onTabmore: () {
                        showModalBottomSheet(
                          barrierColor: themeData.colorScheme.onSecondary
                              .withOpacity(0.1),
                          context: context,
                          useRootNavigator: true,
                          backgroundColor: themeData.scaffoldBackgroundColor,
                          //  showDragHandle: true,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
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
                                      title: "Delete this Post?",
                                      description: "",
                                      onTabRemove: () {
                                        BlocProvider.of<ProfileBloc>(context2)
                                            .add(ProfiledeletPostEvent(
                                                user: AuthRepository.readid(),
                                                postid: post[index].id));

                                        Navigator.pop(context);

                                        Navigator.pop(context3);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          snackBarApp(themeData,
                                              'با موفقیت حذف شد', 5, context),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              )
            : SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('You haven\'t postted any danter yet',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
              ),
      ],
    );
  }
}

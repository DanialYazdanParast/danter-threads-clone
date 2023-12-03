import 'package:danter/data/model/follow.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/followers/followers_page_screen/bloc/followers_page_bloc.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/custom_alert_dialog.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image_user_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowersPage extends StatelessWidget {
  final String userid;
  final Followers userFollowers;
  final GestureTapCallback onTabProfileUser;
  const FollowersPage({
    super.key,
    required this.userFollowers,
    required this.userid,
    required this.onTabProfileUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowersPageBloc(locator.get())
        ..add(FollowersPageStartedEvent(
            myuserId: AuthRepository.readid(),
            userIdProfile: userFollowers.user.id)),
      child: BlocBuilder<FollowersPageBloc, FollowersPageState>(
        builder: (context2, state) {
          if (state is FollowersPageSuccesState) {
            return InkWell(
              onTap: onTabProfileUser,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, left: 15, right: 15, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageUserPost(
                        user: userFollowers.user,
                        onTabNameUser: onTabProfileUser),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userFollowers.user.username,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          userFollowers.user.name == ''
                              ? '${userFollowers.user.username}'
                              : '${userFollowers.user.name}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Visibility(
                      visible: userFollowers.user.id != AuthRepository.readid(),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(100, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () async {
                            if (userid == AuthRepository.readid()) {
                              showDialog(
                                barrierColor: Colors.black26,
                                context: context2,
                                builder: (context) {
                                  return CustomAlertDialog(
                                    button: "Remove",
                                    title: "Remove Followers?",
                                    description:
                                        "${userFollowers.user.username}",
                                    onTabRemove: () {
                                      BlocProvider.of<FollowersPageBloc>(
                                              context2)
                                          .add(
                                        FollowersPageDelletfollowhEvent(
                                            myuserId: AuthRepository.readid(),
                                            userIdProfile:
                                                userFollowers.user.id,
                                            followId: userFollowers.id),
                                      );

                                      BlocProvider.of<FollowersBloc>(context2)
                                          .add(
                                        FollowersRefreshEvent(user: userid),
                                      );

                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            } else if (state.truefollowing < 1) {
                              await state.truefollowing++;
                              BlocProvider.of<FollowersPageBloc>(context2).add(
                                FollowersPageAddfollowhEvent(
                                  myuserId: AuthRepository.readid(),
                                  userIdProfile: userFollowers.user.id,
                                ),
                              );
                            } else {
                              await state.truefollowing--;
                              BlocProvider.of<FollowersPageBloc>(context2).add(
                                FollowersPageDelletfollowhEvent(
                                    myuserId: AuthRepository.readid(),
                                    userIdProfile: userFollowers.user.id,
                                    followId: state.followId[0].id),
                              );
                            }
                          },
                          child: Text(
                            userid == AuthRepository.readid()
                                ? 'Remove'
                                : state.truefollowing < 1
                                    ? 'Follow'
                                    : 'Following',
                            style: TextStyle(
                              color: userid == AuthRepository.readid()
                                  ? Colors.black
                                  : state.truefollowing < 1
                                      ? Colors.black
                                      : LightThemeColors.secondaryTextColor,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is FollowersPageInitial) {
            return Container();
          } else if (state is FollowersPageErrorState) {
            return AppErrorWidget(
              exception: state.exception,
              onpressed: () {},
            );
          } else {
            throw Exception('state is not supported ');
          }
        },
      ),
    );
  }
}

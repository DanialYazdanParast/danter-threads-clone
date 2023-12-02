import 'package:danter/data/model/follow.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/followers/followers_page_screen/bloc/followers_page_bloc.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image_user_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowingPage extends StatelessWidget {
  final String userid;
  final Following userFollowing;
      final GestureTapCallback onTabProfileUser;
  const FollowingPage({
    super.key,
    required this.userFollowing,
    required this.userid, required this.onTabProfileUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowersPageBloc(locator.get())
        ..add(FollowersPageStartedEvent(
            myuserId: AuthRepository.readid(), userIdProfile: userFollowing.user.id)),
      child: BlocBuilder<FollowersPageBloc, FollowersPageState>(
        builder: (context, state) {
          if (state is FollowersPageSuccesState) {
            return InkWell(
              onTap: onTabProfileUser,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, left: 15, right: 15, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageUserPost(user: userFollowing.user),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userFollowing.user.username,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          userFollowing.user.name == ''
                              ? '${userFollowing.user.username}'
                              : '${userFollowing.user.name}',
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
                      visible: userFollowing.user.id !=AuthRepository.readid(),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(100, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () async {
                            if (state.truefollowing < 1) {
                              await state.truefollowing++;
                              BlocProvider.of<FollowersPageBloc>(context).add(
                                FollowersPageAddfollowhEvent(
                                  myuserId: AuthRepository.readid(),
                                  userIdProfile: userFollowing.user.id,
                                ),
                              );
                            } else {
                               await state.truefollowing--;
                              BlocProvider.of<FollowersPageBloc>(context).add(
                                FollowersPageDelletfollowhEvent(
                                    myuserId: AuthRepository.readid(),
                                    userIdProfile: userFollowing.user.id,
                                    followId: state.followId[0].id),
                              );
                            }
                          },
                          child: Text(
                            state.truefollowing == 0
                                    ? 'Follow'
                                    : 'Following',
                            style: TextStyle(
                              color:userFollowing.user.id== AuthRepository.readid()
                                  ? LightThemeColors.secondaryTextColor
                                  : state.truefollowing == 0
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

import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/followers/followers_page_screen/followers_page.dart';
import 'package:danter/screen/followers/followers_page_screen/following_page.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/config/theme/theme.dart';
import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowersScreen extends StatefulWidget {
  final String userid;
  final String username;
  const FollowersScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void dispose() {
    followersBloc.close();
    super.dispose();
  }

  final followersBloc = FollowersBloc(locator.get());
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<FollowersBloc>(context).add(
          FollowersRefreshEvent(user: widget.userid),
        );
      },
      child: BlocProvider.value(
        value: followersBloc..add(FollowersStartedEvent(user: widget.userid)),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.username),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.multiply,
                ),
              ),
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: Border(
                            bottom: BorderSide(
                                color: Theme.of(context).colorScheme.onPrimary,
                                width: 0.7),
                          ),
                        ),
                      ),
                    ),
                    TabBar(
                      indicatorPadding:
                          const EdgeInsets.only(left: 20, right: 20),
                      indicatorWeight: 1,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: themeData.colorScheme.onPrimary,
                      labelColor: themeData.colorScheme.onPrimary,
                      unselectedLabelColor: themeData.colorScheme.secondary,
                      labelStyle: themeData.textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                      tabs: const [
                        Tab(
                          child: Text('Followers'),
                        ),
                        Tab(
                          child: Text('Following'),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                    child: TabBarView(children: [
                  BlocBuilder<FollowersBloc, FollowersState>(
                    builder: (context2, state) {
                      if (state is FollowersSuccesState) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          itemCount: state.userFollowers[0].user.length,
                          itemBuilder: (context, index) {
                            return BlocProvider.value(
                              value: followersBloc,
                              child: FollowersPage(
                                userFollowers:
                                    state.userFollowers[0].user[index],
                                userid: widget.userid,
                                onTabProfileUser: () {
                                  if (state.userFollowers[0].user[index].id ==
                                      AuthRepository.readid()) {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const ProfileScreen();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: followersBloc,
                                            child: ProfileUser(
                                              user: state
                                                  .userFollowers[0].user[index],
                                              userid: widget.userid,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                                onTabfolow: () async {
                                  if (widget.userid ==
                                      AuthRepository.readid()) {
                                    showDialog(
                                      barrierColor: themeData
                                          .colorScheme.onPrimary
                                          .withOpacity(0.3),
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                          button: "Remove",
                                          title: "Remove Followers?",
                                          description:
                                              "${state.userFollowers[0].user[index].username}",
                                          onTabRemove: () {
                                            BlocProvider.of<FollowersBloc>(
                                                    context2)
                                                .add(
                                              FollowersRemovefollowhEvent(
                                                userIdProfile: state
                                                    .userFollowers[0]
                                                    .user[index]
                                                    .id,
                                                myuserId:
                                                    AuthRepository.readid(),
                                              ),
                                            );

                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  } else if (!state
                                      .userFollowers[0].user[index].followers
                                      .contains(AuthRepository.readid())) {
                                    BlocProvider.of<FollowersBloc>(context2)
                                        .add(
                                      FollowersAddfollowhEvent(
                                        userIdProfile: state
                                            .userFollowers[0].user[index].id,
                                        myuserId: AuthRepository.readid(),
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<FollowersBloc>(context2)
                                        .add(
                                      FollowersDelletfollowhEvent(
                                        userIdProfile: state
                                            .userFollowers[0].user[index].id,
                                        myuserId: AuthRepository.readid(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        );
                      } else if (state is FollowersLodingState) {
                        return const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: LightThemeColors.secondaryTextColor,
                            ),
                          ),
                        );
                      } else if (state is FollowersErrorState) {
                        return AppErrorWidget(
                          exception: state.exception,
                          onpressed: () {},
                        );
                      } else {
                        throw Exception('state is not supported ');
                      }
                    },
                  ),
                  BlocBuilder<FollowersBloc, FollowersState>(
                    builder: (context, state) {
                      if (state is FollowersSuccesState) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          itemCount: state.userFollowing[0].user.length,
                          itemBuilder: (context, index) {
                            return FollowingPage(
                              userFollowing: state.userFollowing[0].user[index],
                              userid: widget.userid,
                              onTabProfileUser: () {
                                if (state.userFollowing[0].user[index].id ==
                                    AuthRepository.readid()) {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const ProfileScreen();
                                      },
                                    ),
                                  );
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider.value(
                                          value: followersBloc,
                                          child: ProfileUser(
                                            user: state
                                                .userFollowing[0].user[index],
                                            userid: widget.userid,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              onTabfolow: () {
                                if (!state
                                    .userFollowing[0].user[index].followers
                                    .contains(AuthRepository.readid())) {
                                  BlocProvider.of<FollowersBloc>(context).add(
                                    FollowingAddfollowhEvent(
                                      userIdProfile:
                                          state.userFollowing[0].user[index].id,
                                      myuserId: AuthRepository.readid(),
                                    ),
                                  );
                                } else {
                                  BlocProvider.of<FollowersBloc>(context).add(
                                    FollowingDelletfollowhEvent(
                                      userIdProfile:
                                          state.userFollowing[0].user[index].id,
                                      myuserId: AuthRepository.readid(),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      } else if (state is FollowersLodingState) {
                        return const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: LightThemeColors.secondaryTextColor,
                            ),
                          ),
                        );
                      } else if (state is FollowersErrorState) {
                        return AppErrorWidget(
                          exception: state.exception,
                          onpressed: () {},
                        );
                      } else {
                        throw Exception('state is not supported ');
                      }
                    },
                  ),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

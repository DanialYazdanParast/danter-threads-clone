import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/followers/widgets/followers_page.dart';
import 'package:danter/screen/followers/widgets/following_page.dart';
import 'package:danter/screen/profile/screens/profile_screen.dart';
import 'package:danter/screen/profile_user/screens/profile_user.dart';
import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowersScreen extends StatefulWidget {
  final String userid;
  final String username;
  final String namePage;
  const FollowersScreen(
      {super.key,
      required this.userid,
      required this.username,
      this.namePage = ''});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<FollowersBloc>(context)
        .add(FollowersStartedEvent(user: widget.userid));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: EdgeInsets.only(top: !RootScreen.isMobile(context) ? 20 : 0),
        child: Scaffold(
          appBar:
              RootScreen.isMobile(context) || widget.namePage == 'ProfileUser'
                  ? AppBar(
                      title: Text(widget.username),
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          CupertinoIcons.multiply,
                        ),
                      ),
                    )
                  : null,
          body: Padding(
            padding: EdgeInsets.only(
                top: RootScreen.isMobile(context) ? 0 : 10,
                left: RootScreen.isMobile(context) ? 0 : 4,
                right: RootScreen.isMobile(context) ? 0 : 4),
            child: Column(
              children: [
                const TabBar(
                  indicatorPadding: EdgeInsets.only(left: 20, right: 20),
                  indicatorWeight: 1,
                  tabs: [
                    Tab(
                      child: Text('Followers'),
                    ),
                    Tab(
                      child: Text('Following'),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<FollowersBloc, FollowersState>(
                      builder: (context2, state) {
                    if (state is FollowersSuccesState) {
                      return TabBarView(
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.only(top: 8),
                            itemCount: state.userFollowers[0].user.length,
                            itemBuilder: (context, index) {
                              return FollowersPage(
                                userFollowers:
                                    state.userFollowers[0].user[index],
                                userid: widget.userid,
                                onTabProfileUser: () {
                                  if (state.userFollowers[0].user[index].id ==
                                      AuthRepository.readid()) {
                                    Navigator.of(context,
                                            rootNavigator:
                                                RootScreen.isMobile(context)
                                                    ? true
                                                    : false)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const ProfileScreen();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context,
                                            rootNavigator:
                                                RootScreen.isMobile(context)
                                                    ? true
                                                    : false)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ProfileUser(
                                            user: state
                                                .userFollowers[0].user[index],
                                            userid: widget.userid,
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
                                          description: state.userFollowers[0]
                                              .user[index].username,
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
                              );
                            },
                          ),

                          ///---------------------------
                          ListView.builder(
                            padding: const EdgeInsets.only(top: 8),
                            itemCount: state.userFollowing[0].user.length,
                            itemBuilder: (context, index) {
                              return FollowingPage(
                                userFollowing:
                                    state.userFollowing[0].user[index],
                                userid: widget.userid,
                                onTabProfileUser: () {
                                  if (state.userFollowing[0].user[index].id ==
                                      AuthRepository.readid()) {
                                    Navigator.of(context,
                                            rootNavigator:
                                                RootScreen.isMobile(context)
                                                    ? true
                                                    : false)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const ProfileScreen();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context,
                                            rootNavigator:
                                                RootScreen.isMobile(context)
                                                    ? true
                                                    : false)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ProfileUser(
                                            user: state
                                                .userFollowing[0].user[index],
                                            userid: widget.userid,
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
                                        userIdProfile: state
                                            .userFollowing[0].user[index].id,
                                        myuserId: AuthRepository.readid(),
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<FollowersBloc>(context).add(
                                      FollowingDelletfollowhEvent(
                                        userIdProfile: state
                                            .userFollowing[0].user[index].id,
                                        myuserId: AuthRepository.readid(),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      );
                    } else if (state is FollowersLodingState) {
                      return const TabBarView(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                color: LightThemeColors.secondaryTextColor,
                              ),
                            ),
                          ),
                          Center(
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
                    } else if (state is FollowersErrorState) {
                      return TabBarView(
                        children: [
                          AppErrorWidget(
                            exception: state.exception,
                            onpressed: () {
                              BlocProvider.of<FollowersBloc>(context).add(
                                FollowersRefreshEvent(user: widget.userid),
                              );
                            },
                          ),
                          AppErrorWidget(
                            exception: state.exception,
                            onpressed: () {
                              BlocProvider.of<FollowersBloc>(context).add(
                                FollowersRefreshEvent(user: widget.userid),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      throw Exception('state is not supported ');
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

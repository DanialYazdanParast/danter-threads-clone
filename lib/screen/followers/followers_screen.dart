import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/followers/followers_page_screen/followers_page.dart';
import 'package:danter/screen/followers/followers_page_screen/following_page.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/custom_alert_dialog.dart';
import 'package:danter/widgets/error.dart';
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
    return BlocProvider.value(
      value: followersBloc..add(FollowersStartedEvent(user: widget.userid)),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
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
              const TabBar(
                  indicatorWeight: 0.5,
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Shabnam',
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: LightThemeColors.secondaryTextColor,
                  tabs: [
                    Tab(
                      child: Text(
                        'Followers',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Following',
                      ),
                    ),
                  ]),
              Expanded(
                  child: TabBarView(children: [
                BlocBuilder<FollowersBloc, FollowersState>(
                  builder: (context2, state) {
                    if (state is FollowersSuccesState) {
                      return ListView.builder(
                        itemCount: state.userFollowers[0].user.length,
                        itemBuilder: (context, index) {
                          return BlocProvider.value(
                            value: followersBloc,
                            child: FollowersPage(
                              userFollowers: state.userFollowers[0].user[index],
                              userid: widget.userid,
                              onTabProfileUser: () {
                                if (state.userFollowers[0].user[index].id ==
                                    AuthRepository.readid()) {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider(
                                          create: (context) =>
                                              ProfileBloc(locator.get()),
                                          child: ProfileScreen(
                                              profileBloc:
                                                  ProfileBloc(locator.get())),
                                        );
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
                                if (widget.userid == AuthRepository.readid()) {
                                  showDialog(
                                    barrierColor: Colors.black26,
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
                                              myuserId: AuthRepository.readid(),
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
                                  BlocProvider.of<FollowersBloc>(context2).add(
                                    FollowersAddfollowhEvent(
                                      userIdProfile:
                                          state.userFollowers[0].user[index].id,
                                      myuserId: AuthRepository.readid(),
                                    ),
                                  );
                                } else {
                                  BlocProvider.of<FollowersBloc>(context2).add(
                                    FollowersDelletfollowhEvent(
                                      userIdProfile:
                                          state.userFollowers[0].user[index].id,
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
                      return Center(child: CupertinoActivityIndicator());
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
                        itemCount: state.userFollowing[0].user.length,
                        itemBuilder: (context, index) {
                          return FollowingPage(
                            userFollowing: state.userFollowing[0].user[index],
                            userid: widget.userid,
                            onTabProfileUser: () {
                              if (state.userFollowing[0].user[index].id ==
                                  AuthRepository.readid()) {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) =>
                                            ProfileBloc(locator.get()),
                                        child: ProfileScreen(
                                            profileBloc:
                                                ProfileBloc(locator.get())),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                Navigator.of(context, rootNavigator: true).push(
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
                              if (!state.userFollowing[0].user[index].followers
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
                      return Center(child: CupertinoActivityIndicator());
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
    );
  }
}

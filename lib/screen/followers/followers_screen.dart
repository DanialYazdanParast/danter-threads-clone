import 'package:danter/data/model/follow.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image_user_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowersScreen extends StatelessWidget {
  final String userid;
  final String username;
  const FollowersScreen(
      {super.key, required this.userid, required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowersBloc(locator.get())
        ..add(FollowersStartedEvent(user: userid)),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(username),
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
                  builder: (context, state) {
                    if (state is FollowersSuccesState) {
                      return ListView.builder(
                        itemCount: state.userFollowers.length,
                        itemBuilder: (context, index) {
                          return FollowersPage(
                            userFollowers: state.userFollowers[index],
                            userid: userid,
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
                        itemCount: state.userFollowing.length,
                        itemBuilder: (context, index) {
                          return FollowingPage(
                            userFollowing: state.userFollowing[index],
                            userid: userid,
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

class FollowersPage extends StatelessWidget {
  final String userid;
  final Followers userFollowers;
  const FollowersPage({
    super.key,
    required this.userFollowers,
    required this.userid,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageUserPost(user: userFollowers.user),
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
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            const Spacer(),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(100, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () async {
                  //   if (state.truefollowing == 0) {
                  //     await state.truefollowing++;

                  //     BlocProvider.of<LikedDetailBloc>(context).add(
                  //       LikedDetailAddfollowhEvent(
                  //           myuserId: AuthRepository.readid(),
                  //           userIdProfile: user.id),
                  //     );
                  //   } else {
                  //     await state.truefollowing--;
                  //     BlocProvider.of<LikedDetailBloc>(context).add(
                  //       LikedDetailDelletfollowhEvent(
                  //           myuserId: AuthRepository.readid(),
                  //           userIdProfile: user.id,
                  //           followId: state.followId[0].id),
                  //     );
                  //   }
                },
                child: Text(
                  //    state.truefollowing < 1 ? 'Follow' : 'Following',
                  userid == AuthRepository.readid() ? 'Remove' : 'Follow',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class FollowingPage extends StatelessWidget {
  final String userid;
  final Following userFollowing;
  const FollowingPage({
    super.key,
    required this.userFollowing,
    required this.userid,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 10),
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
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            const Spacer(),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(100, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () async {
                  //   if (state.truefollowing == 0) {
                  //     await state.truefollowing++;

                  //     BlocProvider.of<LikedDetailBloc>(context).add(
                  //       LikedDetailAddfollowhEvent(
                  //           myuserId: AuthRepository.readid(),
                  //           userIdProfile: user.id),
                  //     );
                  //   } else {
                  //     await state.truefollowing--;
                  //     BlocProvider.of<LikedDetailBloc>(context).add(
                  //       LikedDetailDelletfollowhEvent(
                  //           myuserId: AuthRepository.readid(),
                  //           userIdProfile: user.id,
                  //           followId: state.followId[0].id),
                  //     );
                  //   }
                },
                child: Text(
                  //    state.truefollowing < 1 ? 'Follow' : 'Following',
                  userid == AuthRepository.readid() ? 'Following' : 'Follow',

                  style: TextStyle(
                    color: userid == AuthRepository.readid()
                        ? LightThemeColors.secondaryTextColor
                        : Colors.black,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

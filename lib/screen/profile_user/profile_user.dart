import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/followers/followers_screen.dart';
import 'package:danter/screen/likes/bloc/likes_bloc.dart';
import 'package:danter/screen/profile_user/bloc/profile_user_bloc.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image.dart';

import 'package:danter/widgets/postlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser(
      {super.key,
      required this.user,
      this.idpostEntity = '0',
      this.userid = '0'});
  final User user;
  final String idpostEntity;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => ProfileUserBloc(locator.get())
          ..add(ProfileUserStartedEvent(
              myuserId: AuthRepository.readid(), userIdProfile: user.id)),
        child: SafeArea(
          child: BlocBuilder<ProfileUserBloc, ProfileUserState>(
            builder: (context, state) {
              if (state is ProfileUserSuccesState) {
                return DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          pinned: true,
                          actions: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset(
                                'assets/images/more.png',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            user.name == ''
                                                ? user.username
                                                : '${user.name}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    fontSize: 25,
                                                    overflow:
                                                        TextOverflow.clip),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                user.username,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Container(
                                                  color:
                                                      const Color(0xffF5F5F5),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    child: Text(
                                                      'danter.net',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffA1A1A1),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Visibility(
                                            visible: user.bio!.isNotEmpty,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${user.bio}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    FollowersScreen(
                                                  userid: user.id,
                                                  username: user.username,
                                                ),
                                              ));
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                state.totalfollowers > 1
                                                    ? Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          (state
                                                                  .userFollowers[
                                                                      0]
                                                                  .user
                                                                  .avatarchek
                                                                  .isNotEmpty)
                                                              ? ImageReplyUser(
                                                                  photo: state
                                                                      .userFollowers[
                                                                          0]
                                                                      .user
                                                                      .avatar,
                                                                )
                                                              : const PhotoReplyUserNoPhoto(),
                                                          Positioned(
                                                            left: 13,
                                                            bottom: 0,
                                                            child: (state
                                                                    .userFollowers[
                                                                        1]
                                                                    .user
                                                                    .avatarchek
                                                                    .isNotEmpty)
                                                                ? ImageReplyUser(
                                                                    photo: state
                                                                        .userFollowers[
                                                                            1]
                                                                        .user
                                                                        .avatar,
                                                                  )
                                                                : const PhotoReplyUserNoPhoto(),
                                                          )
                                                        ],
                                                      )
                                                    : state.totalfollowers == 1
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0),
                                                            child: (state
                                                                    .userFollowers[
                                                                        0]
                                                                    .user
                                                                    .avatarchek
                                                                    .isNotEmpty)
                                                                ? ImageReplyUser(
                                                                    photo: state
                                                                        .userFollowers[
                                                                            0]
                                                                        .user
                                                                        .avatar,
                                                                  )
                                                                : const PhotoReplyUserNoPhoto(),
                                                          )
                                                        : Container(
                                                            
                                                          ),
                                                SizedBox(
                                                  width:
                                                      state.totalfollowers == 0? 0: state.totalfollowers == 1? 10:20
                                                ),
                                                Text(
                                                  state.totalfollowers
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                        fontSize: 20,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  state.totalfollowers < 2
                                                      ? 'follower'
                                                      : 'followers',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                        fontSize: 20,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    (user.avatarchek.isNotEmpty)
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox(
                                                height: 84,
                                                width: 84,
                                                child: ImageLodingService(
                                                    imageUrl: user.avatar)),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              height: 84,
                                              width: 84,
                                              color: LightThemeColors
                                                  .secondaryTextColor
                                                  .withOpacity(0.4),
                                              child: const Icon(
                                                CupertinoIcons.person_fill,
                                                color: Colors.white,
                                                size: 97,
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    ButtonPrpfile(
                                      truefollowing: state.truefollowing,
                                      onTabfollow: () async {
                                        if (state.truefollowing == 0) {
                                          await state.truefollowing++;

                                          BlocProvider.of<ProfileUserBloc>(
                                                  context)
                                              .add(
                                            ProfileUserAddfollowhEvent(
                                                myuserId:
                                                    AuthRepository.readid(),
                                                userIdProfile: user.id),
                                          );
                                          if (userid != '0') {
                                            BlocProvider.of<FollowersBloc>(
                                                    context)
                                                .add(
                                              FollowersStartedEvent(
                                                  user: userid),
                                            );
                                          }

                                          if (idpostEntity != '0') {
                                            BlocProvider.of<LikesBloc>(context)
                                                .add(LikesStartedEvent(
                                                    postId: idpostEntity));
                                          }
                                        } else {
                                          await state.truefollowing--;
                                          BlocProvider.of<ProfileUserBloc>(
                                                  context)
                                              .add(
                                            ProfileUserDelletfollowhEvent(
                                                myuserId:
                                                    AuthRepository.readid(),
                                                userIdProfile: user.id,
                                                followId: state.followId[0].id),
                                          );

                                          if (userid != '0') {
                                            BlocProvider.of<FollowersBloc>(
                                                    context)
                                                .add(
                                              FollowersStartedEvent(
                                                  user: userid),
                                            );
                                          }

                                          if (idpostEntity != '0') {
                                            BlocProvider.of<LikesBloc>(context)
                                                .add(LikesStartedEvent(
                                                    postId: idpostEntity));
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: TabBarViewDelegate(
                            const TabBar(
                              indicatorWeight: 0.5,
                              indicatorColor: Colors.black,
                              labelColor: Colors.black,
                              unselectedLabelColor:
                                  LightThemeColors.secondaryTextColor,
                              tabs: [
                                Tab(icon: Text('Danter')),
                                Tab(icon: Text('Replies')),
                              ],
                            ),
                          ),
                          pinned: false,
                          floating: true,
                        ),
                      ];
                    },
                    body: TabBarView(children: [
                      CustomScrollView(
                        slivers: [
                          (state.post.isNotEmpty)
                              ? SliverList.builder(
                                  itemCount: state.post.length,
                                  itemBuilder: (context, index) {
                                    return PostList(
                                      postEntity: state.post[index],
                                      onTabNameUser: () {},
                                    );
                                  },
                                )
                              : SliverToBoxAdapter(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Center(
                                      child: Text(
                                        'No danter yet',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w100),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        color: const Color(0xff1C1F2E),
                      ),
                    ]),
                  ),
                );
              } else if (state is ProfileUserLodingState) {
                return Center(child: CupertinoActivityIndicator());
              } else if (state is ProfileUserErrorState) {
                return AppErrorWidget(
                  exception: state.exception,
                  onpressed: () {},
                );
              } else {
                throw Exception('state is not supported ');
              }
            },
          ),
        ),
      ),
    );
  }
}

//---------ButtonPrpfile-------------//
class ButtonPrpfile extends StatelessWidget {
  final int truefollowing;
  const ButtonPrpfile({
    super.key,
    required this.truefollowing,
    required this.onTabfollow,
  });

  final GestureTapCallback onTabfollow;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor:
                  truefollowing < 1 ? Colors.black : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: onTabfollow,
          child: Text(
            truefollowing < 1 ? 'Follow' : 'Following',
            style: TextStyle(
              color: truefollowing < 1 ? Colors.white : Colors.black,
            ),
          )),
    );
  }
}

//---------TabBarView-------------//
class TabBarViewDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  TabBarViewDelegate(this._tabBar);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

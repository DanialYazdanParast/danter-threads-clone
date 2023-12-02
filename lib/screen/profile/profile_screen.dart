import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/followers/followers_screen.dart';

import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image.dart';

import 'package:danter/theme.dart';
import 'package:danter/widgets/photoUserFollowers.dart';
import 'package:danter/widgets/postlist.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context)
        .add(ProfileStartedEvent(user: AuthRepository.readid()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccesState) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<ProfileBloc>(context)
                      .add(ProfileRefreshEvent(user: AuthRepository.readid()));
                },
                child: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        const SliverAppBar(
                          pinned: true,
                          actions: [
                            Icon(Icons.menu),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                          //       leading: Icon(Icons.language),
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
                                            (AuthRepository.loadAuthInfo()!.name.isEmpty)
                                                ? AuthRepository.loadAuthInfo()!
                                                    .username
                                                : AuthRepository.loadAuthInfo()!
                                                    .name,
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
                                                AuthRepository.loadAuthInfo()!
                                                    .username,
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
                                          Visibility(
                                            visible:
                                                AuthRepository.loadAuthInfo()!
                                                    .bio!
                                                    .isNotEmpty,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  AuthRepository.loadAuthInfo()!
                                                      .bio!,
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
                                                  userid:
                                                      AuthRepository.readid(),
                                                  username: AuthRepository
                                                          .loadAuthInfo()!
                                                      .username,
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
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0),
                                                          ),
                                                SizedBox(
                                                  width:
                                                      state.totalfollowers == 0
                                                          ? 0
                                                          : 10,
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
                                                  'followers',
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
                                    (AuthRepository.loadAuthInfo()!
                                            .avatarchek
                                            .isNotEmpty)
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox(
                                                height: 84,
                                                width: 84,
                                                child: ImageLodingService(
                                                    imageUrl: AuthRepository
                                                            .loadAuthInfo()!
                                                        .avatar)),
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
                                const Row(
                                  children: [
                                    ButtonPrpfile(name: 'Edit profile'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ButtonPrpfile(name: 'Share profile'),
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
                                        'You haven\'t postted any danter yet',
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
                ),
              );
            } else if (state is ProfileLodingState) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is ProfileErrorState) {
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
    );
  }
}

class ButtonPrpfile extends StatelessWidget {
  const ButtonPrpfile({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          onPressed: () {},
          child: Text(name)),
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

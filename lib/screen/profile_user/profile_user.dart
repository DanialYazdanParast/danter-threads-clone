import 'package:danter/core/util/exceptions.dart';
import 'package:danter/core/widgets/loding.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/chat_screen.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/followers/followers_screen.dart';
import 'package:danter/screen/likes/bloc/likes_bloc.dart';
import 'package:danter/screen/profile_user/bloc/profile_user_bloc.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/core/widgets/image.dart';
import 'package:danter/core/widgets/photoUserFollowers.dart';
import 'package:danter/core/widgets/post_detail.dart';
import 'package:danter/core/widgets/replies_detail.dart';
import 'package:danter/screen/search/search_screen/bloc/search_bloc.dart';
import 'package:danter/screen/search/search_user/bloc/search_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser(
      {super.key,
      required this.user,
      this.idpostEntity = '0',
      this.userid = '0',
      this.search = '0',
      this.searchuser = '0'});
  final User user;
  final String idpostEntity;
  final String userid;
  final String search;
  final String searchuser;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileUserBloc(locator.get())
          ..add(ProfileUserStartedEvent(
              myuserId: AuthRepository.readid(), user: user.id)),
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
                                color: themeData.colorScheme.onPrimary,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          NameProfileUser(user: user),
                                          UserNameProfileUser(user: user),
                                        ],
                                      ),
                                    ),
                                    ImageProfileUser(
                                      user: user,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BioProfileUser(user: user),
                                    ImageAndTotalFollowers(
                                        user: state.user,
                                        userFollowers:
                                            state.userFollowers[0].user),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    ButtonProfile(
                                      user: state.user,
                                      onTabfollow: () async {
                                        if (!state.user.followers.contains(
                                            AuthRepository.readid())) {
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

                                          if (search != '0') {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(SearchStartEvent(
                                              AuthRepository.readid(),
                                            ));
                                          }

                                          if (searchuser != '0') {
                                            BlocProvider.of<SearchUserBloc>(
                                                    context)
                                                .add(SearchUserKeyUsernameEvent(
                                                    userId:
                                                        AuthRepository.readid(),
                                                    keyUsername: searchuser));
                                          }
                                        } else {
                                          BlocProvider.of<ProfileUserBloc>(
                                                  context)
                                              .add(
                                            ProfileUserDelletfollowhEvent(
                                              myuserId: AuthRepository.readid(),
                                              userIdProfile: user.id,
                                            ),
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

                                          if (search != '0') {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(SearchStartEvent(
                                              AuthRepository.readid(),
                                            ));
                                          }

                                          if (searchuser != '0') {
                                            BlocProvider.of<SearchUserBloc>(
                                                    context)
                                                .add(SearchUserKeyUsernameEvent(
                                                    userId:
                                                        AuthRepository.readid(),
                                                    keyUsername: searchuser));
                                          }
                                        }
                                      },
                                    ),

                                    const SizedBox(
                                      width: 20,
                                    ),

                                    /////
                                    ButtonMessage(
                                      name: 'Message',
                                      onTabButtonPrpfile: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => ChatBloc(
                                                locator.get())
                                              ..add(ChatInitilzeEvent(
                                                  myuserid:
                                                      AuthRepository.readid(),
                                                  useridchat: user.id)),
                                            child: ChatScreen(
                                              user: user,
                                            ),
                                          ),
                                        ));
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: TabBarViewDelegate(
                            TabBar(
                              indicatorPadding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              indicatorWeight: 1,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: themeData.colorScheme.onPrimary,
                              labelColor: themeData.colorScheme.onPrimary,
                              unselectedLabelColor:
                                  themeData.colorScheme.secondary,
                              labelStyle: themeData.textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.w700),
                              tabs: const [
                                Tab(icon: Text('Danter')),
                                Tab(icon: Text('Replies')),
                              ],
                            ),
                          ),
                          pinned: true,
                          floating: false,
                        ),
                        const SliverPadding(padding: EdgeInsets.only(top: 10))
                      ];
                    },
                    body: TabBarView(children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<ProfileUserBloc>(context).add(
                              ProfileUserRefreshEvent(
                                  myuserId: AuthRepository.readid(),
                                  user: user.id));
                          await Future.delayed(const Duration(seconds: 2));
                        },
                        child: DanterProfileUser(post: state.post),
                      ),
                      RefreshIndicator(
                          onRefresh: () async {
                            BlocProvider.of<ProfileUserBloc>(context).add(
                                ProfileUserRefreshEvent(
                                    myuserId: AuthRepository.readid(),
                                    user: user.id));
                            await Future.delayed(const Duration(seconds: 2));
                          },
                          child: RepliesPage(reply: state.reply)),
                    ]),
                  ),
                );
              } else if (state is ProfileUserLodingState) {
                return LodingProfileUser(
                  user: user,
                );
              } else if (state is ProfileUserErrorState) {
                return ErrorProfileUser(
                  user: user,
                  exception: state.exception,
                  onpressed: () {
                    BlocProvider.of<ProfileUserBloc>(context).add(
                        ProfileUserRefreshEvent(
                            myuserId: AuthRepository.readid(), user: user.id));
                  },
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

class DanterProfileUser extends StatelessWidget {
  const DanterProfileUser({super.key, required this.post});

  final List<PostEntity> post;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        (post.isNotEmpty)
            ? SliverList.builder(
                itemCount: post.length,
                itemBuilder: (context, index) {
                  return PostDetail(
                      onTabLike: () {
                        if (!post[index]
                            .likes
                            .contains(AuthRepository.readid())) {
                          BlocProvider.of<ProfileUserBloc>(context).add(
                            AddLikeProfileUserEvent(
                              postId: post[index].id,
                              user: AuthRepository.readid(),
                            ),
                          );
                        } else {
                          BlocProvider.of<ProfileUserBloc>(context).add(
                            RemoveLikeProfileUserEvent(
                              postId: post[index].id,
                              user: AuthRepository.readid(),
                            ),
                          );
                        }
                      },
                      postEntity: post[index],
                      onTabmore: () {});
                },
              )
            : SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('No danter yet',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
              ),
      ],
    );
  }
}

class RepliesPage extends StatelessWidget {
  final List<PostReply> reply;
  const RepliesPage({
    super.key,
    required this.reply,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: reply.length,
          itemBuilder: (context, index) {
            return RepliseDtaile(
              onTabLikeMyReply: () {
                if (!reply[index]
                    .myReply
                    .likes
                    .contains(AuthRepository.readid())) {
                  BlocProvider.of<ProfileUserBloc>(context).add(
                    AddLikeMyReplyProfileUserEvent(
                      postId: reply[index].myReply.id,
                      user: AuthRepository.readid(),
                    ),
                  );
                } else {
                  BlocProvider.of<ProfileUserBloc>(context).add(
                    RemoveLikeMyReplyProfileUserEvent(
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
                  BlocProvider.of<ProfileUserBloc>(context).add(
                    AddLikeReplyToProfileUserEvent(
                      postId: reply[index].replyTo.id,
                      user: AuthRepository.readid(),
                    ),
                  );
                } else {
                  BlocProvider.of<ProfileUserBloc>(context).add(
                    RemoveLikeReplyToProfileUserEvent(
                      postId: reply[index].replyTo.id,
                      user: AuthRepository.readid(),
                    ),
                  );
                }
              },
              postEntity: reply[index],
              onTabNameUser: () {},
              onTabmore: () {},
            );
          },
        )
      ],
    );
  }
}

class NameProfileUser extends StatelessWidget {
  const NameProfileUser({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Text(
      user.name == '' ? user.username : '${user.name}',
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(overflow: TextOverflow.clip),
    );
  }
}

class UserNameProfileUser extends StatelessWidget {
  const UserNameProfileUser({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        Text(
          user.username,
          style: themeData.textTheme.labelLarge!.copyWith(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: themeData.colorScheme.onBackground,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Text(
                'danter.net',
                style: themeData.textTheme.titleSmall!.copyWith(
                  fontSize: 10,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BioProfileUser extends StatelessWidget {
  const BioProfileUser({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: user.bio!.isNotEmpty,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          '${user.bio}',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.2),
        ),
      ),
    );
  }
}

//---------ButtonPrpfile-------------//
class ButtonProfile extends StatelessWidget {
  final User user;
  const ButtonProfile({
    super.key,
    required this.onTabfollow,
    required this.user,
  });

  final GestureTapCallback onTabfollow;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Expanded(
      child: Container(
        height: 34,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor:
                    user.followers.contains(AuthRepository.readid())
                        ? themeData.scaffoldBackgroundColor
                        : themeData.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: onTabfollow,
            child: Text(
                user.followers.contains(AuthRepository.readid())
                    ? 'Following'
                    : 'Follow',
                style: user.followers.contains(AuthRepository.readid())
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w400)
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: themeData.scaffoldBackgroundColor,
                        fontWeight: FontWeight.w400))),
      ),
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
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class ImageAndTotalFollowers extends StatelessWidget {
  const ImageAndTotalFollowers({
    super.key,
    required this.userFollowers,
    required this.user,
  });

  final List<User> userFollowers;
  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => FollowersScreen(
            userid: user.id,
            username: user.username,
          ),
        ));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userFollowers.length > 1
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    (userFollowers[0].avatarchek.isNotEmpty)
                        ? ImageReplyUser(
                            photo: userFollowers[0].avatar,
                          )
                        : const PhotoReplyUserNoPhoto(),
                    Positioned(
                      left: 13,
                      bottom: 0,
                      child: (userFollowers[1].avatarchek.isNotEmpty)
                          ? ImageReplyUser(
                              photo: userFollowers[1].avatar,
                            )
                          : const PhotoReplyUserNoPhoto(),
                    )
                  ],
                )
              : userFollowers.length == 1
                  ? Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: (userFollowers[0].avatarchek.isNotEmpty)
                          ? ImageReplyUser(
                              photo: userFollowers[0].avatar,
                            )
                          : const PhotoReplyUserNoPhoto(),
                    )
                  : Container(
                      margin: const EdgeInsets.only(left: 0),
                    ),
          SizedBox(
            width: userFollowers.isEmpty
                ? 0
                : userFollowers.length == 1
                    ? 10
                    : 20,
          ),
          Text(
            user.followers.length.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            userFollowers.length < 2 ? 'follower' : 'followers',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

class ImageProfileUser extends StatelessWidget {
  final User user;
  const ImageProfileUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: (user.avatarchek.isNotEmpty)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                      height: 74,
                      width: 74,
                      child: ImageLodingService(imageUrl: user.avatar)),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                      height: 74,
                      width: 74,
                      child: Image.asset('assets/images/profile.png')),
                ),
        ),
        Positioned(
          bottom: -1,
          left: -1,
          child: Visibility(
            visible: user.tik,
            child: SizedBox(
                width: 27,
                height: 27,
                child: Image.asset(
                  'assets/images/tik.png',
                  color: Theme.of(context).scaffoldBackgroundColor,
                )),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Visibility(
            visible: user.tik,
            child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/images/tik.png')),
          ),
        ),
      ],
    );
  }
}

class LodingProfileUser extends StatelessWidget {
  const LodingProfileUser({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        DefaultTabController(
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
                        color: themeData.colorScheme.onPrimary,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  NameProfileUser(user: user),
                                  UserNameProfileUser(user: user),
                                ],
                              ),
                            ),
                            ImageProfileUser(
                              user: user,
                            )
                          ],
                        ),
                        BioProfileUser(user: user),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ButtonProfile(
                              user: user,
                              onTabfollow: () async {},
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ButtonMessage(
                              name: 'Message',
                              onTabButtonPrpfile: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => ChatBloc(locator.get())
                                      ..add(ChatInitilzeEvent(
                                          myuserid: AuthRepository.readid(),
                                          useridchat: user.id)),
                                    child: ChatScreen(
                                      user: user,
                                    ),
                                  ),
                                ));
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: TabBarViewDelegate(
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
                        Tab(icon: Text('Danter')),
                        Tab(icon: Text('Replies')),
                      ],
                    ),
                  ),
                  pinned: true,
                  floating: false,
                ),
                const SliverPadding(padding: EdgeInsets.only(top: 10))
              ];
            },
            body: TabBarView(children: [
              Container(),
              Container(),
            ]),
          ),
        ),
        Positioned(top: 94, child: LodingCustom())
      ],
    );
  }
}

class ErrorProfileUser extends StatelessWidget {
  const ErrorProfileUser({
    super.key,
    required this.user,
    required this.exception,
    required this.onpressed,
  });
  final User user;
  final AppException exception;
  final GestureTapCallback onpressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
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
                    color: themeData.colorScheme.onPrimary,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              NameProfileUser(user: user),
                              UserNameProfileUser(user: user),
                            ],
                          ),
                        ),
                        ImageProfileUser(
                          user: user,
                        )
                      ],
                    ),
                    BioProfileUser(user: user),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ButtonProfile(
                          user: user,
                          onTabfollow: () async {},
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ButtonMessage(
                          name: 'Message',
                          onTabButtonPrpfile: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => ChatBloc(locator.get())
                                  ..add(ChatInitilzeEvent(
                                      myuserid: AuthRepository.readid(),
                                      useridchat: user.id)),
                                child: ChatScreen(
                                  user: user,
                                ),
                              ),
                            ));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: TabBarViewDelegate(
                TabBar(
                  indicatorPadding: const EdgeInsets.only(left: 20, right: 20),
                  indicatorWeight: 1,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: themeData.colorScheme.onPrimary,
                  labelColor: themeData.colorScheme.onPrimary,
                  unselectedLabelColor: themeData.colorScheme.secondary,
                  labelStyle: themeData.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                  tabs: const [
                    Tab(icon: Text('Danter')),
                    Tab(icon: Text('Replies')),
                  ],
                ),
              ),
              pinned: true,
              floating: false,
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 10))
          ];
        },
        body: TabBarView(children: [
          Column(
            children: [
              const SizedBox(height: 20),
              AppErrorWidget(
                exception: exception,
                onpressed: onpressed,
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              AppErrorWidget(
                exception: exception,
                onpressed: onpressed,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class ButtonMessage extends StatelessWidget {
  const ButtonMessage({
    super.key,
    required this.name,
    required this.onTabButtonPrpfile,
  });

  final String name;
  final GestureTapCallback onTabButtonPrpfile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      height: 34,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onTabButtonPrpfile,
        child: Text(name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                //  color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.w400)),
      ),
    ));
  }
}

import 'package:danter/data/model/post.dart';
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
import 'package:danter/widgets/photoUserFollowers.dart';

import 'package:danter/widgets/post_detail.dart';
import 'package:danter/widgets/replies_detail.dart';
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
                        child: CustomScrollView(
                          slivers: [
                            (state.post.isNotEmpty)
                                ? SliverList.builder(
                                    itemCount: state.post.length,
                                    itemBuilder: (context, index) {
                                      return PostDetail(
                                          onTabLike: () {
                                            if (!state.post[index].likes
                                                .contains(
                                                    AuthRepository.readid())) {
                                              BlocProvider.of<ProfileUserBloc>(
                                                      context)
                                                  .add(
                                                AddLikeProfileUserEvent(
                                                  postId: state.post[index].id,
                                                  user: AuthRepository.readid(),
                                                ),
                                              );
                                            } else {
                                              BlocProvider.of<ProfileUserBloc>(
                                                      context)
                                                  .add(
                                                RemoveLikeProfileUserEvent(
                                                  postId: state.post[index].id,
                                                  user: AuthRepository.readid(),
                                                ),
                                              );
                                            }
                                          },
                                          postEntity: state.post[index],
                                          onTabmore: () {});
                                    },
                                  )
                                : SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Center(
                                        child: Text('No danter yet',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
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
              onTabmore: () {
                // showModalBottomSheet(
                //   context: context,
                //   useRootNavigator: true,
                //   backgroundColor: Colors.white,
                //   showDragHandle: true,
                //   shape: const RoundedRectangleBorder(
                //       borderRadius:
                //           BorderRadius.vertical(top: Radius.circular(16))),
                //   builder: (context3) {
                //     return Padding(
                //       padding: const EdgeInsets.only(top: 10, bottom: 24),
                //       child: InkWell(
                //         onTap: () {
                //           showDialog(
                //             useRootNavigator: true,
                //             barrierDismissible: false,
                //             barrierColor: Colors.black26,
                //             context: context,
                //             builder: (context) {
                //               return CustomAlertDialog(
                //                 button: 'Delete',
                //                 title: "Delete this Post?",
                //                 description: "",
                //                 onTabRemove: () {
                //                   // BlocProvider.of<
                //                   //             ProfileBloc>(
                //                   //         context2)
                //                   //     .add(ProfiledeletPostEvent(
                //                   //         user: AuthRepository
                //                   //             .readid(),
                //                   //         postid: state
                //                   //             .post[index]
                //                   //             .id));

                //                   // Navigator.pop(context);

                //                   // Navigator.pop(context3);

                //                   // ScaffoldMessenger.of(
                //                   //         context)
                //                   //     .showSnackBar(
                //                   //   SnackBar(
                //                   //     margin: const EdgeInsets
                //                   //         .only(
                //                   //         bottom: 35,
                //                   //         left: 30,
                //                   //         right: 30),

                //                   //     //  width: 280.0,
                //                   //     padding:
                //                   //         const EdgeInsets
                //                   //             .symmetric(
                //                   //       horizontal: 10,
                //                   //     ),
                //                   //     behavior:
                //                   //         SnackBarBehavior
                //                   //             .floating,
                //                   //     shape: RoundedRectangleBorder(
                //                   //         borderRadius:
                //                   //             BorderRadius
                //                   //                 .circular(
                //                   //                     15)),
                //                   //     content: const Center(
                //                   //         child: Padding(
                //                   //       padding:
                //                   //           EdgeInsets.all(
                //                   //               14),
                //                   //       child: Text(
                //                   //           'با موفقیت حذف شد'),
                //                   //     )),
                //                   //   ),
                //                   // );
                //                 },
                //               );
                //             },
                //           );
                //         },
                //         child: Container(
                //           margin: const EdgeInsets.only(left: 20, right: 20),
                //           height: 50,
                //           decoration: BoxDecoration(
                //               color: LightThemeColors.secondaryTextColor
                //                   .withOpacity(0.2),
                //               borderRadius: BorderRadius.circular(5)),
                //           child: const Center(
                //               child: Text(
                //             'Delete',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w400,
                //                 color: Colors.red,
                //                 fontSize: 16),
                //           )),
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
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
    return Stack(
      //   fit: StackFit.passthrough,
      alignment: Alignment.bottomCenter,

      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary, width: 0.7),
            ),
          ),

          // child: _tabBar,
        ),
        Positioned(bottom: 0.5, left: 0, right: 0, child: _tabBar),
      ],
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
    return (user.avatarchek.isNotEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
                height: 74,
                width: 74,
                child: ImageLodingService(imageUrl: user.avatar)),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
                height: 74,
                width: 74,
                child: Image.asset('assets/images/profile.png')),
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
        Positioned(
          top: 95,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: themeData.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    width: 1, color: themeData.colorScheme.secondary)),
            child: Center(
              child: SizedBox(
                height: 18,
                width: 18,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: themeData.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

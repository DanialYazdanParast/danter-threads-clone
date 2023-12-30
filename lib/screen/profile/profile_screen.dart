import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/screen/followers/followers_screen.dart';

import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/edit_profile/edit_profile.dart';

import 'package:danter/screen/settings/settings_Screen.dart';

import 'package:danter/widgets/custom_alert_dialog.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image.dart';

import 'package:danter/theme.dart';
import 'package:danter/widgets/photoUserFollowers.dart';

import 'package:danter/widgets/post_detail.dart';
import 'package:danter/widgets/replies_detail.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.profileBloc});
  final ProfileBloc profileBloc;

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
          builder: (context2, state) {
            if (state is ProfileSuccesState) {
              return 
              DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        actions: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingScreen()));
                            },
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.asset(
                                'assets/images/Frame 29.png',
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        NameProfile(),
                                     //   const SizedBox(height: 10),
                                        const UserNameProfile(),
                                      ],
                                    ),
                                  ),
                                  ImageProfile()
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BioProfile(),
                                  const SizedBox(height: 10),
                                  ImageAndTotalFollowers(
                                      userFollowers:
                                          state.userFollowers[0].user),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RowButtonProfile(profileBloc: widget.profileBloc),
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
                    RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        BlocProvider.of<ProfileBloc>(context).add(
                            ProfileRefreshEvent(user: AuthRepository.readid()));
                      },
                      child:

                       DanterPage(post: state.post, context2: context2),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        BlocProvider.of<ProfileBloc>(context).add(
                            ProfileRefreshEvent(user: AuthRepository.readid()));
                      },
                      child: RepliesPage(reply: state.reply),
                    )
                  ]),
                ),
              );
            } else if (state is ProfileLodingState) {
              return LodingProfile(
                profileBloc: widget.profileBloc,
              );
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

class ImageProfile extends StatelessWidget {
  ImageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthRepository.loadAuthInfo()!.avatarchek.isNotEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
                height: 84,
                width: 84,
                child: ImageLodingService(
                    imageUrl: AuthRepository.loadAuthInfo()!.avatar)),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 84,
              width: 84,
              color: LightThemeColors.secondaryTextColor.withOpacity(0.4),
              child: const Icon(
                CupertinoIcons.person_fill,
                color: Colors.white,
                size: 97,
              ),
            ),
          );
  }
}

class RowButtonProfile extends StatelessWidget {
  const RowButtonProfile({
    super.key,
    required this.profileBloc,
  });

  final ProfileBloc profileBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonPrpfile(
          name: 'Edit profile',
          onTabButtonPrpfile: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: profileBloc,
                child: EditProfile(),
              ),
            ));
          },
        ),
        const SizedBox(
          width: 20,
        ),
        ButtonPrpfile(
          name: 'Share profile',
          onTabButtonPrpfile: () {},
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
                  BlocProvider.of<ProfileBloc>(context).add(
                    AddLikeMyReplyProfileEvent(
                      postId: reply[index].myReply.id,
                      user: AuthRepository.readid(),
                    ),
                  );
                } else {
                  BlocProvider.of<ProfileBloc>(context).add(
                    RemoveLikeMyReplyProfileEvent(
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
                  BlocProvider.of<ProfileBloc>(context).add(
                    AddLikeReplyToProfileEvent(
                      postId: reply[index].replyTo.id,
                      user: AuthRepository.readid(),
                    ),
                  );
                } else {
                  BlocProvider.of<ProfileBloc>(context).add(
                    RemoveLikeReplyToProfileEvent(
                      postId: reply[index].replyTo.id,
                      user: AuthRepository.readid(),
                    ),
                  );
                }
              },
              postEntity: reply[index],
              onTabNameUser: () {},
              onTabmore: () {
                showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  backgroundColor: Colors.white,
                  showDragHandle: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  builder: (context3) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 24),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            useRootNavigator: true,
                            barrierDismissible: false,
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) {
                              return CustomAlertDialog(
                                button: 'Delete',
                                title: "Delete this Post?",
                                description: "",
                                onTabRemove: () {
                                  // BlocProvider.of<
                                  //             ProfileBloc>(
                                  //         context2)
                                  //     .add(ProfiledeletPostEvent(
                                  //         user: AuthRepository
                                  //             .readid(),
                                  //         postid: state
                                  //             .post[index]
                                  //             .id));

                                  // Navigator.pop(context);

                                  // Navigator.pop(context3);

                                  // ScaffoldMessenger.of(
                                  //         context)
                                  //     .showSnackBar(
                                  //   SnackBar(
                                  //     margin: const EdgeInsets
                                  //         .only(
                                  //         bottom: 35,
                                  //         left: 30,
                                  //         right: 30),

                                  //     //  width: 280.0,
                                  //     padding:
                                  //         const EdgeInsets
                                  //             .symmetric(
                                  //       horizontal: 10,
                                  //     ),
                                  //     behavior:
                                  //         SnackBarBehavior
                                  //             .floating,
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius:
                                  //             BorderRadius
                                  //                 .circular(
                                  //                     15)),
                                  //     content: const Center(
                                  //         child: Padding(
                                  //       padding:
                                  //           EdgeInsets.all(
                                  //               14),
                                  //       child: Text(
                                  //           'با موفقیت حذف شد'),
                                  //     )),
                                  //   ),
                                  // );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 50,
                          decoration: BoxDecoration(
                              color: LightThemeColors.secondaryTextColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            'Delete',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                                fontSize: 16),
                          )),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        )
      ],
    );
  }
}

class DanterPage extends StatelessWidget {
  final List<PostEntity> post;
  final BuildContext context2;
  const DanterPage({
    super.key,
    required this.post,
    required this.context2,
  });

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
                        BlocProvider.of<ProfileBloc>(context).add(
                          AddLikeProfileEvent(
                            postId: post[index].id,
                            user: AuthRepository.readid(),
                          ),
                        );
                      } else {
                        BlocProvider.of<ProfileBloc>(context).add(
                          RemoveLikeProfileEvent(
                            postId: post[index].id,
                            user: AuthRepository.readid(),
                          ),
                        );
                      }
                    },
                    postEntity: post[index],
                    onTabmore: () {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        backgroundColor: Colors.white,
                        showDragHandle: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16))),
                        builder: (context3) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 24),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  useRootNavigator: true,
                                  barrierDismissible: false,
                                  barrierColor: Colors.black26,
                                  context: context,
                                  builder: (context) {
                                    return CustomAlertDialog(
                                      button: 'Delete',
                                      title: "Delete this Post?",
                                      description: "",
                                      onTabRemove: () {
                                        BlocProvider.of<ProfileBloc>(context2)
                                            .add(ProfiledeletPostEvent(
                                                user: AuthRepository.readid(),
                                                postid: post[index].id));

                                        Navigator.pop(context);

                                        Navigator.pop(context3);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            margin: const EdgeInsets.only(
                                                bottom: 35,
                                                left: 30,
                                                right: 30),

                                            //  width: 280.0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            content: const Center(
                                                child: Padding(
                                              padding: EdgeInsets.all(14),
                                              child: Text('با موفقیت حذف شد'),
                                            )),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                height: 50,
                                decoration: BoxDecoration(
                                    color: LightThemeColors.secondaryTextColor
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                    child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red,
                                      fontSize: 16),
                                )),
                              ),
                            ),
                          );
                        },
                      );
                    },
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
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class NameProfile extends StatelessWidget {
  NameProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Text(
        (AuthRepository.loadAuthInfo()!.name.isEmpty)
            ? AuthRepository.loadAuthInfo()!.username
            : AuthRepository.loadAuthInfo()!.name,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontSize: 25, overflow: TextOverflow.clip),
      ),
    );
  }
}

class UserNameProfile extends StatelessWidget {
  const UserNameProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AuthRepository.loadAuthInfo()!.username,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: const Color(0xffF5F5F5),
            child: const Padding(
              padding: EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Text(
                'danter.net',
                style: TextStyle(
                    color: Color(0xffA1A1A1),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BioProfile extends StatelessWidget {
  BioProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: AuthRepository.loadAuthInfo()!.bio!.isNotEmpty,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            AuthRepository.loadAuthInfo()!.bio!,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class ImageAndTotalFollowers extends StatelessWidget {
  const ImageAndTotalFollowers({
    super.key,
    required this.userFollowers,
  });

  final List<User> userFollowers;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => FollowersScreen(
            userid: AuthRepository.readid(),
            username: AuthRepository.loadAuthInfo()!.username,
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
            userFollowers.length.toString(),
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 18,
                ),
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            userFollowers.length < 2 ? 'follower' : 'followers',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 18,
                ),
          ),
        ],
      ),
    );
  }
}

class ButtonPrpfile extends StatelessWidget {
  const ButtonPrpfile({
    super.key,
    required this.name,
    required this.onTabButtonPrpfile,
  });

  final String name;
  final GestureTapCallback onTabButtonPrpfile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 34,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            onPressed: onTabButtonPrpfile,
            child: Text(name)),
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

//////////////////////////
///
///
class LodingProfile extends StatelessWidget {
  const LodingProfile({super.key, required this.profileBloc});
  final ProfileBloc profileBloc;

  @override
  Widget build(BuildContext context) {
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
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const SettingScreen()));
                        },
                        child: const Icon(Icons.menu)),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                  //       leading: Icon(Icons.language),
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
                                  const SizedBox(height: 20),
                                  NameProfile(),
                                  const UserNameProfile(),
                                ],
                              ),
                            ),
                            ImageProfile()
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BioProfile(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RowButtonProfile(profileBloc: profileBloc),
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
                      unselectedLabelColor: LightThemeColors.secondaryTextColor,
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
              Container(),
              Container(),
             
            
            ]),
          ),
        ),
        Positioned(
          top: 105,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    width: 1, color: LightThemeColors.secondaryTextColor)),
            child: const Center(
              child: SizedBox(
                height: 18,
                width: 18,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
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


//  LoadingIndicator(
//                         indicatorType: Indicator.ballRotateChase, /// Required, The loading type of the widget
//                         colors: [Color.fromARGB(255, 111, 104, 104) ],       /// Optional, The color collections
//                         strokeWidth: 1,                     /// Optional, The stroke of the line, only applicable to widget which contains line
//                         backgroundColor: Colors.white,      /// Optional, Background of the widget
//                         pathBackgroundColor: Colors.black  
//                          /// Optional, the stroke backgroundColor
//                       ),

















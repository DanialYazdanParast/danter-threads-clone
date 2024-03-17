import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/util/exceptions.dart';
import 'package:danter/core/widgets/loding.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/followers/followers_screen.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/edit_profile/edit_profile.dart';
import 'package:danter/screen/settings/settings_Screen.dart';
import 'package:danter/core/widgets/custom_alert_dialog.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/core/widgets/image.dart';
import 'package:danter/config/theme/theme.dart';
import 'package:danter/core/widgets/photoUserFollowers.dart';
import 'package:danter/core/widgets/post_detail.dart';
import 'package:danter/core/widgets/replies_detail.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context)
        .add(ProfileStartedEvent(user: AuthRepository.readid()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context2, state) {
            if (state is ProfileSuccesState) {
              return DefaultTabController(
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
                              width: 28,
                              height: 28,
                              child: Image.asset(
                                'assets/images/draver.png',
                                color: themeData.colorScheme.onPrimary,
                                //  fit: BoxFit.cover,
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
                                        const SizedBox(height: 10),
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
                                  ImageAndTotalFollowers(
                                      userFollowers:
                                          state.userFollowers[0].user),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const RowButtonProfile(),
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
                        BlocProvider.of<ProfileBloc>(context2).add(
                            ProfileRefreshEvent(user: AuthRepository.readid()));
                        await Future.delayed(const Duration(seconds: 2));
                      },
                      child: DanterPage(post: state.post, context2: context2),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<ProfileBloc>(context2).add(
                            ProfileRefreshEvent(user: AuthRepository.readid()));
                        await Future.delayed(const Duration(seconds: 2));
                      },
                      child:
                          RepliesPage(reply: state.reply, context2: context2),
                    )
                  ]),
                ),
              );
            } else if (state is ProfileLodingState) {
              return const LodingProfile();
            } else if (state is ProfileErrorState) {
              return ErrorProfile(
                  exception: state.exception,
                  onpressed: () {
                    BlocProvider.of<ProfileBloc>(context2).add(
                        ProfileRefreshEvent(user: AuthRepository.readid()));
                  });
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
    return Stack(
      children: [
        Container(
          child: (AuthRepository.loadAuthInfo()!.avatarchek.isNotEmpty)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                      height: 74,
                      width: 74,
                      child: ImageLodingService(
                          imageUrl: AuthRepository.loadAuthInfo()!.avatar)),
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
            visible: AuthRepository.loadAuthInfo()!.tik,
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
            visible: AuthRepository.loadAuthInfo()!.tik,
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

class RowButtonProfile extends StatelessWidget {
  const RowButtonProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonPrpfile(
          name: 'Edit profile',
          onTabButtonPrpfile: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => EditProfile(),
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
  final BuildContext context2;
  const RepliesPage({
    super.key,
    required this.reply,
    required this.context2,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: reply.length,
          itemBuilder: (context, index) {
            return RepliseDtaile(
              namepage: 'ProfileScreenReply',
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
                  barrierColor:
                      themeData.colorScheme.onSecondary.withOpacity(0.1),
                  context: context,
                  useRootNavigator: true,
                  backgroundColor: themeData.scaffoldBackgroundColor,
                  //  showDragHandle: true,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  builder: (context3) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 4,
                          width: 32,
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.secondary,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 24),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                useRootNavigator: true,
                                barrierDismissible: false,
                                barrierColor: themeData.colorScheme.onSecondary
                                    .withOpacity(0.1),
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
                                              postid: reply[index].myReply.id));

                                      Navigator.pop(context);

                                      Navigator.pop(context3);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        snackBarApp(
                                            themeData, 'با موفقیت حذف شد', 5),
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
                                  color: themeData.colorScheme.onBackground,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                'Delete',
                                style: TextStyle(
                                    //        fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 18),
                              )),
                            ),
                          ),
                        ),
                      ],
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
    final ThemeData themeData = Theme.of(context);
    return CustomScrollView(
      slivers: [
        (post.isNotEmpty)
            ? SliverList.builder(
                itemCount: post.length,
                itemBuilder: (context, index) {
                  return PostDetail(
                    namepage: 'ProfileScreen',
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
                        barrierColor:
                            themeData.colorScheme.onSecondary.withOpacity(0.1),
                        context: context,
                        useRootNavigator: true,
                        backgroundColor: themeData.scaffoldBackgroundColor,
                        //  showDragHandle: true,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16))),
                        builder: (context3) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 4,
                                width: 32,
                                decoration: BoxDecoration(
                                    color: themeData.colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 50, bottom: 24),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      useRootNavigator: true,
                                      barrierDismissible: false,
                                      barrierColor: themeData
                                          .colorScheme.onSecondary
                                          .withOpacity(0.1),
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                          button: 'Delete',
                                          title: "Delete this Post?",
                                          description: "",
                                          onTabRemove: () {
                                            BlocProvider.of<ProfileBloc>(
                                                    context2)
                                                .add(ProfiledeletPostEvent(
                                                    user:
                                                        AuthRepository.readid(),
                                                    postid: post[index].id));

                                            Navigator.pop(context);

                                            Navigator.pop(context3);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              snackBarApp(themeData,
                                                  'با موفقیت حذف شد', 5),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color:
                                            themeData.colorScheme.onBackground,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Center(
                                        child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          //        fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 18),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              )
            : SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('You haven\'t postted any danter yet',
                        style: Theme.of(context).textTheme.titleSmall),
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
            .labelLarge!
            .copyWith(overflow: TextOverflow.clip),
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
    final ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        Text(
          AuthRepository.loadAuthInfo()!.username,
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

class BioProfile extends StatelessWidget {
  const BioProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: AuthRepository.loadAuthInfo()!.bio!.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          AuthRepository.loadAuthInfo()!.bio!,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.2),
        ),
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
          Text(userFollowers.length.toString(),
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(
            width: 6,
          ),
          Text(userFollowers.length < 2 ? 'follower' : 'followers',
              style: Theme.of(context).textTheme.titleSmall),
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
      child: SizedBox(
        height: 34,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            onPressed: onTabButtonPrpfile,
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w400),
            )),
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

//////////////////////////

class LodingProfile extends StatelessWidget {
  const LodingProfile({
    super.key,
  });

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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => const SettingScreen()));
                      },
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset(
                          'assets/images/draver.png',
                          color: themeData.colorScheme.onPrimary,
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
                                  SizedBox(height: 10),
                                  NameProfile(),
                                  // const SizedBox(height: 5),
                                  UserNameProfile(),
                                ],
                              ),
                            ),
                            ImageProfile()
                          ],
                        ),
                        BioProfile(),
                        const RowButtonProfile(),
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
              ];
            },
            body: TabBarView(children: [
              Container(),
              Container(),
            ]),
          ),
        ),
        const Positioned(top: 94, child: LodingCustom())
      ],
    );
  }
}

//////////////////////////

class ErrorProfile extends StatelessWidget {
  const ErrorProfile({
    super.key,
    required this.exception,
    required this.onpressed,
  });
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => const SettingScreen()));
                  },
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: Image.asset(
                      'assets/images/draver.png',
                      color: themeData.colorScheme.onPrimary,
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
                              SizedBox(height: 10),
                              NameProfile(),
                              // const SizedBox(height: 5),
                              UserNameProfile(),
                            ],
                          ),
                        ),
                        ImageProfile()
                      ],
                    ),
                    BioProfile(),
                    const RowButtonProfile(),
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

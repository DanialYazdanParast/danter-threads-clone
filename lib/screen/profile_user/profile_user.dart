import 'package:danter/data/model/user.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/bloc/profile_user_bloc.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image.dart';
import 'package:danter/widgets/postlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => ProfileUserBloc(locator.get())
          ..add(ProfileUserStartedEvent(user: user.id)),
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
                        child: HederProfile(user: user),
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
                                      onTabNameUser: (){},
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
              );

                }else if (state is ProfileUserLodingState) {
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

//---------HederProfile-------------//
class HederProfile extends StatelessWidget {
  final User user;
  const HederProfile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.name == '' ? '${user.username}' : '${user.name}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 25, overflow: TextOverflow.clip),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '${user.username}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            color: const Color(0xffF5F5F5),
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
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
                                    fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PhotoUserFollowers(),
                        const SizedBox(
                          width: 18,
                        ),
                        Text(
                          '412',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'followers',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              (user.avatarchek.isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                          height: 84,
                          width: 84,
                          child: ImageLodingService(imageUrl: user.avatar)),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 84,
                        width: 84,
                        color: LightThemeColors.secondaryTextColor
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
              ButtonPrpfile(),
            ],
          ),
        ],
      ),
    );
  }
}

//---------ButtonPrpfile-------------//
class ButtonPrpfile extends StatelessWidget {
  const ButtonPrpfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: () {},
          child: const Text(
            'Follow',
            style: TextStyle(
              color: Colors.white,
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

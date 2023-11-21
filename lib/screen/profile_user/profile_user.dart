import 'package:danter/screen/profile/profilescree.dart';
import 'package:danter/widgets/postlist.dart';
import 'package:danter/theme.dart';

import 'package:flutter/material.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTabController(
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
                const SliverToBoxAdapter(
                  child: HederProfile(),
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
              CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return const PostList();
                    },
                  ),
                ],
              ),
              Container(
                color: const Color(0xff1C1F2E),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

//---------HederProfile-------------//
class HederProfile extends StatelessWidget {
  const HederProfile({
    super.key,
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
                      'Daniel YazdanParast',
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
                          'Daniel',
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
                    Text(
                      'bio fhgfjghjgjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 84,
                  width: 84,
                  child: Image.asset(
                    'assets/images/me.jpg',
                  ),
                ),
              ),
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

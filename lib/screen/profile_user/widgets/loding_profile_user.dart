import 'package:danter/core/widgets/loding.dart';
import 'package:danter/core/widgets/tabbar_view_delegate.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/screen/profile_user/widgets/header_user_error_and_loding.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

class LodingProfileUser extends StatelessWidget {
  const LodingProfileUser({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverVisibility(
                        visible: RootScreen.isMobile(context),
                        sliver: SliverToBoxAdapter(
                          child: HeaderUserErrorAndLoding(user: user),
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: TabBarViewDelegate(
                          const TabBar(
                            indicatorPadding:
                                EdgeInsets.only(left: 20, right: 20),
                            indicatorWeight: 1,
                            tabs: [
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
                const Positioned(top: 94, child: LodingCustom())
              ],
            ),
          ),
          Visibility(
            visible: !RootScreen.isMobile(context),
            child: SizedBox(
                width: 360, child: HeaderUserErrorAndLoding(user: user)),
          ),
        ],
      ),
    );
  }
}

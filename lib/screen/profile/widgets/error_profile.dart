import 'package:danter/core/util/exceptions.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/core/widgets/tabbar_view_delegate.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/followers/screens/followers_screen.dart';
import 'package:danter/screen/profile/widgets/header.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

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
      child: Row(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverVisibility(
                    visible: RootScreen.isMobile(context),
                    sliver: const SliverToBoxAdapter(
                      child: Header(userFollowers: []),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: TabBarViewDelegate(
                      const TabBar(
                        indicatorPadding: EdgeInsets.only(left: 20, right: 20),
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
          ),
          Visibility(
            visible: !RootScreen.isMobile(context),
            child: SizedBox(
                width: 360,
                child: Column(
                  children: [
                    const Header(userFollowers: []),
                    Expanded(
                        child: FollowersScreen(
                      userid: AuthRepository.readid(),
                      username: AuthRepository.loadAuthInfo()!.username,
                    )),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

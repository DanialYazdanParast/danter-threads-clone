import 'package:danter/core/util/exceptions.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/core/widgets/tabbar_view_delegate.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/screen/profile_user/widgets/header_user_error_and_loding.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

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
      child: Row(
        children: [
          Expanded(
            child: NestedScrollView(
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
                      TabBar(
                        indicatorPadding:
                            const EdgeInsets.only(left: 20, right: 20),
                        indicatorWeight: 1,
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

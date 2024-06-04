import 'package:danter/core/widgets/tabbar_view_delegate.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/profile_user/bloc/profile_user_bloc.dart';
import 'package:danter/screen/profile_user/widgets/danter_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/error_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/header_user.dart';
import 'package:danter/screen/profile_user/widgets/loding_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/replies_page_user.dart';
import 'package:danter/screen/root/screens/root.dart';
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
    return Container(
      color: themeData.scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(top: !RootScreen.isMobile(context) ? 20 : 0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: AppBar(
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
          ),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: NestedScrollView(
                              headerSliverBuilder:
                                  (context, innerBoxIsScrolled) {
                                return [
                                  SliverVisibility(
                                    visible: RootScreen.isMobile(context),
                                    sliver: SliverToBoxAdapter(
                                      child: SizedBox(
                                        width: 360,
                                        child: HeaderUser(
                                            state: state,
                                            user: user,
                                            userid: userid,
                                            idpostEntity: idpostEntity,
                                            search: search,
                                            searchuser: searchuser),
                                      ),
                                    ),
                                  ),
                                  SliverPersistentHeader(
                                    delegate: TabBarViewDelegate(
                                      const TabBar(
                                        indicatorPadding: EdgeInsets.only(
                                            left: 20, right: 20),
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
                                  const SliverPadding(
                                      padding: EdgeInsets.only(top: 10))
                                ];
                              },
                              body: TabBarView(children: [
                                RefreshIndicator(
                                  onRefresh: () async {
                                    BlocProvider.of<ProfileUserBloc>(context)
                                        .add(ProfileUserRefreshEvent(
                                            myuserId: AuthRepository.readid(),
                                            user: user.id));
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                  },
                                  child: DanterProfileUser(post: state.post),
                                ),
                                RefreshIndicator(
                                    onRefresh: () async {
                                      BlocProvider.of<ProfileUserBloc>(context)
                                          .add(ProfileUserRefreshEvent(
                                              myuserId: AuthRepository.readid(),
                                              user: user.id));
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                    },
                                    child: RepliesPage(reply: state.reply)),
                              ]),
                            ),
                          ),
                          Visibility(
                            visible: !RootScreen.isMobile(context),
                            child: SizedBox(
                              width: 360,
                              child: HeaderUser(
                                  state: state,
                                  user: user,
                                  userid: userid,
                                  idpostEntity: idpostEntity,
                                  search: search,
                                  searchuser: searchuser),
                            ),
                          ),
                        ],
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
                                myuserId: AuthRepository.readid(),
                                user: user.id));
                      },
                    );
                  } else {
                    throw Exception('state is not supported ');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

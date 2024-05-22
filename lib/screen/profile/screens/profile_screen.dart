import 'package:danter/core/widgets/tabbar_view_delegate.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/followers/screens/followers_screen.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/widgets/danter_page.dart';
import 'package:danter/screen/profile/widgets/error_profile.dart';
import 'package:danter/screen/profile/widgets/header.dart';
import 'package:danter/screen/profile/widgets/loding_profile.dart';
import 'package:danter/screen/profile/widgets/replies_page.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/settings/screens/settings_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final String namePage;
  const ProfileScreen({
    super.key,
    this.namePage = '',
  });

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
    final ThemeData themeData = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: !RootScreen.isMobile(context) ? 20 : 0),
      child: Scaffold(
        appBar: RootScreen.isMobile(context) || widget.namePage == ''
            ? PreferredSize(
                preferredSize: const Size.fromHeight(55),
                child: AppBar(
                  actions: [
                    RootScreen.isMobile(context)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => const SettingScreen(),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: Image.asset(
                                'assets/images/draver.png',
                                color: themeData.colorScheme.onPrimary,
                                //  fit: BoxFit.cover,
                              ),
                            ))
                        : Container(),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                  //       leading: Icon(Icons.language),
                ),
              )
            : null,
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context2, state) {
              if (state is ProfileSuccesState) {
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
                                    child: Header(
                                        userFollowers: state.userFollowers)),
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
                              const SliverPadding(
                                  padding: EdgeInsets.only(top: 10))
                            ];
                          },
                          body: TabBarView(children: [
                            RefreshIndicator(
                              onRefresh: () async {
                                BlocProvider.of<ProfileBloc>(context2).add(
                                    ProfileRefreshEvent(
                                        user: AuthRepository.readid()));
                                await Future.delayed(
                                    const Duration(seconds: 2));
                              },
                              child: DanterPage(
                                post: state.post,
                                context2: context2,
                              ),
                            ),
                            RefreshIndicator(
                              onRefresh: () async {
                                BlocProvider.of<ProfileBloc>(context2).add(
                                    ProfileRefreshEvent(
                                        user: AuthRepository.readid()));
                                await Future.delayed(
                                    const Duration(seconds: 2));
                              },
                              child: RepliesPage(
                                  reply: state.reply, context2: context2),
                            )
                          ]),
                        ),
                      ),
                      Visibility(
                        visible: !RootScreen.isMobile(context),
                        child: SizedBox(
                            width: 360,
                            child: Column(
                              children: [
                                Header(userFollowers: state.userFollowers),
                                Expanded(
                                    child: FollowersScreen(
                                  userid: AuthRepository.readid(),
                                  username:
                                      AuthRepository.loadAuthInfo()!.username,
                                )),
                              ],
                            )),
                      )
                    ],
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
      ),
    );
  }
}

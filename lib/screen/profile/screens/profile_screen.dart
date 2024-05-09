import 'package:danter/core/widgets/tabbar_view_delegate.dart';
import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/screen/profile/bloc/profile_bloc.dart';

import 'package:danter/screen/profile/widgets/bio_profile.dart';
import 'package:danter/screen/profile/widgets/danter_page.dart';
import 'package:danter/screen/profile/widgets/error_profile.dart';
import 'package:danter/screen/profile/widgets/image_and_total_followers.dart';
import 'package:danter/screen/profile/widgets/image_profile.dart';
import 'package:danter/screen/profile/widgets/loding_profile.dart';
import 'package:danter/screen/profile/widgets/name_profile.dart';
import 'package:danter/screen/profile/widgets/replies_page.dart';
import 'package:danter/screen/profile/widgets/row_button_profile.dart';

import 'package:danter/screen/profile/widgets/user_name_profile.dart';

import 'package:danter/screen/settings/screens/settings_Screen.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          actions: [
            GestureDetector(
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
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          //       leading: Icon(Icons.language),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context2, state) {
            if (state is ProfileSuccesState) {
              return DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
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
                                    userFollowers: state.userFollowers[0].user,
                                  ),
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

import 'package:danter/core/widgets/tabbar_view_delegate.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/screens/chat_screen.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/likes/bloc/likes_bloc.dart';
import 'package:danter/screen/profile_user/bloc/profile_user_bloc.dart';
import 'package:danter/screen/profile_user/widgets/bio_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/button_message.dart';
import 'package:danter/screen/profile_user/widgets/button_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/danter_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/error_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/image_and_total_followers.dart';
import 'package:danter/screen/profile_user/widgets/image_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/loding_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/name_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/replies_page_user.dart';
import 'package:danter/screen/profile_user/widgets/user_name_profile_user.dart';
import 'package:danter/screen/search/search_screen/bloc/search_bloc.dart';
import 'package:danter/screen/search/search_user/bloc/search_user_bloc.dart';

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
    return Scaffold(
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
                                          NameProfileUser(user: user),
                                          UserNameProfileUser(user: user),
                                        ],
                                      ),
                                    ),
                                    ImageProfileUser(
                                      user: user,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BioProfileUser(user: user),
                                    ImageAndTotalFollowers(
                                        user: state.user,
                                        userFollowers:
                                            state.userFollowers[0].user),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    ButtonProfile(
                                      user: state.user,
                                      onTabfollow: () async {
                                        if (!state.user.followers.contains(
                                            AuthRepository.readid())) {
                                          BlocProvider.of<ProfileUserBloc>(
                                                  context)
                                              .add(
                                            ProfileUserAddfollowhEvent(
                                                myuserId:
                                                    AuthRepository.readid(),
                                                userIdProfile: user.id),
                                          );
                                          if (userid != '0') {
                                            BlocProvider.of<FollowersBloc>(
                                                    context)
                                                .add(
                                              FollowersStartedEvent(
                                                  user: userid),
                                            );
                                          }

                                          if (idpostEntity != '0') {
                                            BlocProvider.of<LikesBloc>(context)
                                                .add(LikesStartedEvent(
                                                    postId: idpostEntity));
                                          }

                                          if (search != '0') {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(SearchStartEvent(
                                              AuthRepository.readid(),
                                            ));
                                          }

                                          if (searchuser != '0') {
                                            BlocProvider.of<SearchUserBloc>(
                                                    context)
                                                .add(SearchUserKeyUsernameEvent(
                                                    userId:
                                                        AuthRepository.readid(),
                                                    keyUsername: searchuser));
                                          }
                                        } else {
                                          BlocProvider.of<ProfileUserBloc>(
                                                  context)
                                              .add(
                                            ProfileUserDelletfollowhEvent(
                                              myuserId: AuthRepository.readid(),
                                              userIdProfile: user.id,
                                            ),
                                          );

                                          if (userid != '0') {
                                            BlocProvider.of<FollowersBloc>(
                                                    context)
                                                .add(
                                              FollowersStartedEvent(
                                                  user: userid),
                                            );
                                          }

                                          if (idpostEntity != '0') {
                                            BlocProvider.of<LikesBloc>(context)
                                                .add(LikesStartedEvent(
                                                    postId: idpostEntity));
                                          }

                                          if (search != '0') {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(SearchStartEvent(
                                              AuthRepository.readid(),
                                            ));
                                          }

                                          if (searchuser != '0') {
                                            BlocProvider.of<SearchUserBloc>(
                                                    context)
                                                .add(SearchUserKeyUsernameEvent(
                                                    userId:
                                                        AuthRepository.readid(),
                                                    keyUsername: searchuser));
                                          }
                                        }
                                      },
                                    ),

                                    const SizedBox(
                                      width: 20,
                                    ),

                                    /////
                                    ButtonMessage(
                                      name: 'Message',
                                      onTabButtonPrpfile: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => ChatBloc(
                                                locator.get())
                                              ..add(ChatInitilzeEvent(
                                                  myuserid:
                                                      AuthRepository.readid(),
                                                  useridchat: user.id)),
                                            child: ChatScreen(
                                              user: user,
                                            ),
                                          ),
                                        ));
                                      },
                                    )
                                  ],
                                ),
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
                          BlocProvider.of<ProfileUserBloc>(context).add(
                              ProfileUserRefreshEvent(
                                  myuserId: AuthRepository.readid(),
                                  user: user.id));
                          await Future.delayed(const Duration(seconds: 2));
                        },
                        child: DanterProfileUser(post: state.post),
                      ),
                      RefreshIndicator(
                          onRefresh: () async {
                            BlocProvider.of<ProfileUserBloc>(context).add(
                                ProfileUserRefreshEvent(
                                    myuserId: AuthRepository.readid(),
                                    user: user.id));
                            await Future.delayed(const Duration(seconds: 2));
                          },
                          child: RepliesPage(reply: state.reply)),
                    ]),
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
                            myuserId: AuthRepository.readid(), user: user.id));
                  },
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

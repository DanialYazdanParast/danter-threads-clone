import 'package:danter/core/di/di.dart';
import 'package:danter/core/widgets/loding.dart';
import 'package:danter/core/widgets/tabbar_view_delegate.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/screens/chat_screen.dart';
import 'package:danter/screen/profile_user/widgets/bio_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/button_message.dart';
import 'package:danter/screen/profile_user/widgets/button_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/image_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/name_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/user_name_profile_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LodingProfileUser extends StatelessWidget {
  const LodingProfileUser({
    super.key,
    required this.user,
  });
  final User user;

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
                        BioProfileUser(user: user),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ButtonProfile(
                              user: user,
                              onTabfollow: () async {},
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ButtonMessage(
                              name: 'Message',
                              onTabButtonPrpfile: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => ChatBloc(locator.get())
                                      ..add(ChatInitilzeEvent(
                                          myuserid: AuthRepository.readid(),
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
                const SliverPadding(padding: EdgeInsets.only(top: 10))
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

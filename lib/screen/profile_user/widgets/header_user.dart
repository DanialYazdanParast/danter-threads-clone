import 'package:danter/core/di/di.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/screens/chat_screen.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/likes/bloc/likes_bloc.dart';
import 'package:danter/screen/profile_user/bloc/profile_user_bloc.dart';
import 'package:danter/screen/profile_user/widgets/bio_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/button_message.dart';
import 'package:danter/screen/profile_user/widgets/button_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/image_and_total_followers.dart';
import 'package:danter/screen/profile_user/widgets/image_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/name_profile_user.dart';
import 'package:danter/screen/profile_user/widgets/user_name_profile_user.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/search/search_screen/bloc/search_bloc.dart';
import 'package:danter/screen/search/search_user/bloc/search_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderUser extends StatelessWidget {
  const HeaderUser({
    super.key,
    required this.user,
    required this.userid,
    required this.idpostEntity,
    required this.search,
    required this.searchuser,
    required this.state,
  });

  final User user;
  final String userid;
  final String idpostEntity;
  final String search;
  final String searchuser;
  final ProfileUserSuccesState state;

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BioProfileUser(user: user),
              ImageAndTotalFollowers(
                  user: state.user, userFollowers: state.userFollowers[0].user),
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
                  if (!state.user.followers.contains(AuthRepository.readid())) {
                    BlocProvider.of<ProfileUserBloc>(context).add(
                      ProfileUserAddfollowhEvent(
                          myuserId: AuthRepository.readid(),
                          userIdProfile: user.id),
                    );
                    if (userid != '0') {
                      BlocProvider.of<FollowersBloc>(context).add(
                        FollowersStartedEvent(user: userid),
                      );
                    }

                    if (idpostEntity != '0') {
                      BlocProvider.of<LikesBloc>(context)
                          .add(LikesStartedEvent(postId: idpostEntity));
                    }

                    if (search != '0') {
                      BlocProvider.of<SearchBloc>(context).add(SearchStartEvent(
                        AuthRepository.readid(),
                      ));
                    }

                    if (searchuser != '0') {
                      BlocProvider.of<SearchUserBloc>(context).add(
                          SearchUserKeyUsernameEvent(
                              userId: AuthRepository.readid(),
                              keyUsername: searchuser));
                    }
                  } else {
                    BlocProvider.of<ProfileUserBloc>(context).add(
                      ProfileUserDelletfollowhEvent(
                        myuserId: AuthRepository.readid(),
                        userIdProfile: user.id,
                      ),
                    );

                    if (userid != '0') {
                      BlocProvider.of<FollowersBloc>(context).add(
                        FollowersStartedEvent(user: userid),
                      );
                    }

                    if (idpostEntity != '0') {
                      BlocProvider.of<LikesBloc>(context)
                          .add(LikesStartedEvent(postId: idpostEntity));
                    }

                    if (search != '0') {
                      BlocProvider.of<SearchBloc>(context).add(SearchStartEvent(
                        AuthRepository.readid(),
                      ));
                    }

                    if (searchuser != '0') {
                      BlocProvider.of<SearchUserBloc>(context).add(
                          SearchUserKeyUsernameEvent(
                              userId: AuthRepository.readid(),
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
                          rootNavigator:
                              RootScreen.isMobile(context) ? true : false)
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
    );
  }
}

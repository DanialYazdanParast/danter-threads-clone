import 'package:danter/core/di/di.dart';
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
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderUserErrorAndLoding extends StatelessWidget {
  const HeaderUserErrorAndLoding({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
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

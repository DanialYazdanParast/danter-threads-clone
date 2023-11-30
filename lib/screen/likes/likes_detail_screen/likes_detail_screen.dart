import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/likes/likes_detail_screen/bloc/liked_detail_bloc.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/image_user_post.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedDetailScreen extends StatelessWidget {
  final User user;
    final GestureTapCallback onTabProfile;
  const LikedDetailScreen({super.key, required this.user, required this.onTabProfile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikedDetailBloc(locator.get())
        ..add(LikedDetailStartedEvent(
          myuserId: AuthRepository.readid(),
          userIdProfile: user.id,
        )),
      child: BlocBuilder<LikedDetailBloc, LikedDetailState>(
        builder: (context, state) {
          if (state is LikedDetailSuccesState) {
            return InkWell(
              onTap: onTabProfile,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, left: 15, right: 15, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageUserPost(user: user),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.username,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          user.name == '' ? '${user.username}' : '${user.name}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                    Spacer(),
                    Visibility(
                      visible: user.id != AuthRepository.readid(),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(100, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () async {
                            if (state.truefollowing == 0) {
                              await state.truefollowing++;

                              BlocProvider.of<LikedDetailBloc>(context).add(
                                LikedDetailAddfollowhEvent(
                                    myuserId: AuthRepository.readid(),
                                    userIdProfile: user.id),
                              );
                            } else {
                              await state.truefollowing--;
                              BlocProvider.of<LikedDetailBloc>(context).add(
                                LikedDetailDelletfollowhEvent(
                                    myuserId: AuthRepository.readid(),
                                    userIdProfile: user.id,
                                    followId: state.followId[0].id),
                              );
                            }
                          },
                          child: Text(
                            state.truefollowing < 1 ? 'Follow' : 'Following',
                            style: TextStyle(
                                color: state.truefollowing < 1
                                    ? Colors.black
                                    : LightThemeColors.secondaryTextColor),
                          )),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is LikedDetailInitial) {
            return Container();
          } else if (state is LikedDetailErrorState) {
            return AppErrorWidget(
              exception: state.exception,
              onpressed: () {},
            );
          } else {
            throw Exception('state is not supported ');
          }
        },
      ),
    );
  }
}

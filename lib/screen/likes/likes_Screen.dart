import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/likes/bloc/likes_bloc.dart';
import 'package:danter/screen/likes/likes_detail_screen.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikesScreen extends StatefulWidget {
  final String idpostEntity;
  const LikesScreen({super.key, required this.idpostEntity});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  void dispose() {
    likesBloc.close();
    super.dispose();
  }

  final likesBloc = LikesBloc(locator.get());
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: likesBloc..add(LikesStartedEvent(postId: widget.idpostEntity)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Likes'),
        ),
        body: SafeArea(
          child: BlocBuilder<LikesBloc, LikesState>(
            builder: (context, state) {
              if (state is LikesSuccesState) {
                return ListView.builder(
                  itemCount: state.user[0].user.length,
                  itemBuilder: (context, index) {
                    return LikedDetailScreen(
                      onTabFollow: (){

                          if (!state.user[0].user[index].followers.contains(AuthRepository.readid())) {
                              BlocProvider.of<LikesBloc>(context).add(
                                LikedAddfollowhEvent(
                                  userIdProfile: state.user[0].user[index].id,
                                  myuserId: AuthRepository.readid(),
                                ),
                              );
                            } else {
                              BlocProvider.of<LikesBloc>(context).add(
                                LikedDelletfollowhEvent(
                                  userIdProfile: state.user[0].user[index].id,
                                  myuserId: AuthRepository.readid(),
                                ),
                              );
                            }


                      },
                      user: state.user[0].user[index],
                      onTabProfile: () {
                        if (state.user[0].user[index].id ==
                            AuthRepository.readid()) {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) =>
                                      ProfileBloc(locator.get()),
                                  child:ProfileScreen(profileBloc: ProfileBloc(locator.get())),
                                );
                              },
                            ),
                          );
                        } else {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return BlocProvider.value(
                                   value: likesBloc,
                                  child: ProfileUser(
                                    user: state.user[0].user[index],
                                    idpostEntity: widget.idpostEntity,
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              } else if (state is LikesLodingState) {
                return const Center(
                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                      color:
                                          LightThemeColors.secondaryTextColor,
                                    ),
                                  ),
                );
              } else if (state is LikesErrorState) {
                return AppErrorWidget(
                  exception: state.exception,
                  onpressed: () {},
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

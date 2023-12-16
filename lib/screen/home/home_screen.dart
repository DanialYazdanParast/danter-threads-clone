import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/main.dart';

import 'package:danter/screen/home/bloc/home_bloc.dart';
import 'package:danter/screen/profile_user/profile_user.dart';

import 'package:danter/widgets/error.dart';
import 'package:danter/widgets/postlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => HomeBloc(locator.get())
          ..add(HomeStartedEvent(user: AuthRepository.readid())),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccesState) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<HomeBloc>(context)
                      .add(HomeRefreshEvent(user: AuthRepository.readid()));
                },
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: false,
                      title: SizedBox(
                        height: 40,
                        width: 40,
                        child: GestureDetector(
                          onTap: () {
                         
                          },
                          child: Image.asset(
                            'assets/images/d.png',
                          ),
                        ),
                      ),
                      centerTitle: true,
                    ),
                    SliverList.builder(
                      itemCount: state.post.length,
                      itemBuilder: (context, index) {
                        return PostList(
                          onTabmore: (){},
                          postEntity: state.post[index],onTabNameUser: (){

                           Navigator.of(context, rootNavigator: true)
                                .push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProfileUser(user: state.post[index].user ,);
                                },
                              ),
                            );

                        },);
                      },
                    ),
                  ],
                ),
              );
            } else if (state is HomeLodingState) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is HomeErrorState) {
              return AppErrorWidget(
                exception: state.exception,
                onpressed: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(HomeRefreshEvent(user: AuthRepository.readid()));
                },
              );
            } else {
              throw Exception('state is not supported ');
            }
          },
        ),
      ),
    );
  }
}

import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/home/bloc/home_bloc.dart';
import 'package:danter/core/widgets/post_detail.dart';
import 'package:danter/screen/home/widgets/Home_error.dart';
import 'package:danter/screen/home/widgets/appbar_home.dart';
import 'package:danter/screen/home/widgets/home_loding.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/search/search_screen/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  await Future.delayed(const Duration(seconds: 2));
                },
                child: Scrollbar(
                  controller: _scrollController,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              SliverVisibility(
                                  visible: RootScreen.isMobile(context),
                                  sliver: const AppBarHome()),
                              SliverVisibility(
                                visible: !RootScreen.isMobile(context),
                                sliver: const SliverPadding(
                                    padding: EdgeInsets.only(top: 30)),
                              ),
                              SliverList.builder(
                                itemCount: state.post.length,
                                itemBuilder: (context, index) {
                                  return PostDetail(
                                    namepage: 'HomeScreen',
                                    onTabLike: () async {
                                      if (!state.post[index].likes
                                          .contains(AuthRepository.readid())) {
                                        BlocProvider.of<HomeBloc>(context).add(
                                          AddLikePostEvent(
                                            postId: state.post[index].id,
                                            user: AuthRepository.readid(),
                                          ),
                                        );
                                      } else {
                                        BlocProvider.of<HomeBloc>(context).add(
                                          RemoveLikePostEvent(
                                            postId: state.post[index].id,
                                            user: AuthRepository.readid(),
                                          ),
                                        );
                                      }
                                    },
                                    onTabmore: () {},
                                    postEntity: state.post[index],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: !RootScreen.isMobile(context),
                          child: const VerticalDivider()),
                      Visibility(
                          visible: !RootScreen.isMobile(context),
                          child: const SizedBox(
                              width: 350, child: SearchScreen())),
                    ],
                  ),
                ),
              );
            } else if (state is HomeLodingState) {
              return const HomeLoding();
            } else if (state is HomeErrorState) {
              return HomeError(
                state: state,
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

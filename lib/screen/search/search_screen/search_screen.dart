import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/screen/search/search_screen/bloc/search_bloc.dart';
import 'package:danter/screen/search/search_screen/search_detail.dart';
import 'package:danter/screen/search/search_user/bloc/search_user_bloc.dart';
import 'package:danter/screen/search/search_user/search_user_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void dispose() {
    searchBloc.close();
    super.dispose();
  }

  final searchBloc = SearchBloc(locator.get());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            searchBloc..add(SearchStartEvent(AuthRepository.readid())),
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    title: Text('Search',
                        style: Theme.of(context).textTheme.headlineLarge)),
                SliverPersistentHeader(
                  delegate: SearchViewDelegate(),
                  pinned: true,
                  floating: false,
                ),
              ];
            },
            body: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchSuccesState) {
                  return CustomScrollView(
                    slivers: [
                      SliverList.builder(
                        itemCount: state.user.length,
                        itemBuilder: (context, index) {
                          return SearchDetailScreen(
                            onTabFollow: () {
                              if (!state.user[index].followers
                                  .contains(AuthRepository.readid())) {
                                BlocProvider.of<SearchBloc>(context).add(
                                  SearchAddfollowhEvent(
                                    userIdProfile: state.user[index].id,
                                    myuserId: AuthRepository.readid(),
                                  ),
                                );
                              } else {
                                BlocProvider.of<SearchBloc>(context).add(
                                  SearchDelletfollowhEvent(
                                    userIdProfile: state.user[index].id,
                                    myuserId: AuthRepository.readid(),
                                  ),
                                );
                              }
                            },
                            onTabProfile: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BlocProvider.value(
                                      value: searchBloc,
                                      child: ProfileUser(
                                        user: state.user[index],
                                        search: 'search',
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            user: state.user[index],
                          );
                        },
                      )
                    ],
                  );
                } else if (state is SearchLodingState) {
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: LightThemeColors.secondaryTextColor,
                      ),
                    ),
                  );
                } else if (state is SearchErrorState) {
                  return AppErrorWidget(
                    exception: state.exception,
                    onpressed: () {
                      // BlocProvider.of<ReplyBloc>(context)
                      //     .add(HomeRefreshEvent(user: AuthRepository.readid()));
                    },
                  );
                } else {
                  throw Exception('state is not supported ');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SearchViewDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return SearchUserScreen();
            },
          ));
        },
        child: Container(
          margin:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
            child: Row(children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Image.asset('assets/images/search.png',
                    color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(width: 12),
              Text(
                'Search',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(height: 1.6),
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

import 'package:danter/core/di/di.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/core/widgets/loding.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/profile_user/screens/profile_user.dart';
import 'package:danter/screen/search/search_screen/bloc/search_bloc.dart';
import 'package:danter/screen/search/search_screen/widgets/search_bottom.dart';
import 'package:danter/screen/search/search_screen/widgets/search_detail.dart';
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
              return <Widget>[
                SliverAppBar(
                  titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                  title: const Text(
                    'Search',
                  ),
                  pinned: true,
                  floating: true,
                  bottom: PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 55),
                    child: const SearchBottom(),
                  ),
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
                              Navigator.of(
                                context,
                              ).push(
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
                  return const Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      LodingCustom(),
                    ],
                  );
                } else if (state is SearchErrorState) {
                  return AppErrorWidget(
                    exception: state.exception,
                    onpressed: () {
                      searchBloc.add(SearchStartEvent(AuthRepository.readid()));
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

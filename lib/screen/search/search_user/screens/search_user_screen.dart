import 'package:danter/core/di/di.dart';
import 'package:danter/core/widgets/error.dart';
import 'package:danter/core/widgets/loding.dart';
import 'package:danter/core/widgets/user_detail_follow.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/profile_user/screens/profile_user.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/search/search_user/bloc/search_user_bloc.dart';
import 'package:danter/screen/search/search_user/widgets/search_user_detaile_hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final searchUserBloc = SearchUserBloc(locator.get(), locator.get());
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    searchUserBloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchUserBloc..add(SearchUserGetAllUserHiveEvent()),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: EdgeInsets.only(top: !RootScreen.isMobile(context) ? 20 : 0),
          child: Scaffold(
              appBar: AppBar(
                title: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      searchUserBloc.add(
                        SearchUserKeyUsernameEvent(
                          keyUsername: value,
                          userId: AuthRepository.readid(),
                        ),
                      );
                    },
                    minLines: 1,
                    maxLines: 1,
                    autofocus: true,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(height: 1.6),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(height: 1.6),
                      isCollapsed: true,
                      //  floatingLabelBehavior: FloatingLabelBehavior.always,
                      alignLabelWithHint: true,
                      icon: Image.asset('assets/images/search.png',
                          width: 24,
                          height: 24,
                          isAntiAlias: true,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ),
              body: BlocBuilder<SearchUserBloc, SearchUserState>(
                builder: (context, state) {
                  if (state is SearchUserInitial) {
                    return Container();
                  } else if (state is SearchUserLodingState) {
                    return const LodingCustom();
                  } else if (state is SearchUserHiveSuccesState) {
                    if (state.user.isNotEmpty) {
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Visibility(
                              visible: state.user.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 15, bottom: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Recent',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontSize: 18),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<SearchUserBloc>(
                                                  context)
                                              .add(
                                            SearchUserDeleteAllSearchEvent(),
                                          );
                                        },
                                        child: Text(
                                          'Clear',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 18),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          SliverList.builder(
                            itemCount: state.user.length,
                            itemBuilder: (context, index) {
                              return SearchUserDetailHive(
                                onTabDelete: () {
                                  BlocProvider.of<SearchUserBloc>(context).add(
                                    SearchUserDeleteSearchEvent(
                                      user: state
                                          .user[state.user.length - 1 - index],
                                    ),
                                  );
                                },
                                onTabProfile: () {
                                  //-------------
                                  BlocProvider.of<SearchUserBloc>(context).add(
                                      SearchUserAddSearchHiveEvent(
                                          user: state.user[
                                              state.user.length - 1 - index]));
                                  //-------------

                                  Navigator.of(
                                    context,
                                  ).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProfileUser(
                                          user: state.user[
                                              state.user.length - 1 - index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                user: state.user[state.user.length - 1 - index],
                              );
                            },
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/empty_search.png',
                              height: 180,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withAlpha(90),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'your search list is empty',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    }
                  } else if (state is SearchUserSuccesState) {
                    return ListView.builder(
                      itemCount: state.user.length,
                      itemBuilder: (context, index) {
                        return UserDetailFollow(
                          onTabFollow: () {
                            if (!state.user[index].followers
                                .contains(AuthRepository.readid())) {
                              BlocProvider.of<SearchUserBloc>(context).add(
                                SearchUserAddfollowhEvent(
                                  userIdProfile: state.user[index].id,
                                  myuserId: AuthRepository.readid(),
                                ),
                              );
                            } else {
                              BlocProvider.of<SearchUserBloc>(context).add(
                                SearchUserDelletfollowhEvent(
                                  userIdProfile: state.user[index].id,
                                  myuserId: AuthRepository.readid(),
                                ),
                              );
                            }
                          },
                          onTabProfile: () {
                            BlocProvider.of<SearchUserBloc>(context).add(
                                SearchUserAddSearchEvent(
                                    user: state.user[index]));
                            Navigator.of(
                              context,
                            ).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: searchUserBloc,
                                    child: ProfileUser(
                                      user: state.user[index],
                                      searchuser: _controller.text,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          user: state.user[index],
                        );
                      },
                    );
                  } else if (state is SearchUserErrorState) {
                    return AppErrorWidget(
                      exception: state.exception,
                      onpressed: () {},
                    );
                  } else {
                    throw Exception('state is not supported ');
                  }
                },
              )),
        ),
      ),
    );
  }
}

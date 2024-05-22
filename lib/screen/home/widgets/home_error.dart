import 'package:danter/core/widgets/error.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/home/bloc/home_bloc.dart';
import 'package:danter/screen/home/widgets/appbar_home.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/search/search_screen/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeError extends StatelessWidget {
  const HomeError({super.key, required this.state});
  final HomeErrorState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: CustomScrollView(
              slivers: [
                SliverVisibility(
                    visible: RootScreen.isMobile(context),
                    sliver: const AppBarHome()),
                SliverVisibility(
                  visible: !RootScreen.isMobile(context),
                  sliver:
                      const SliverPadding(padding: EdgeInsets.only(top: 30)),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 1,
                        ),
                        AppErrorWidget(
                          exception: state.exception,
                          onpressed: () {
                            BlocProvider.of<HomeBloc>(context).add(
                                HomeRefreshEvent(
                                    user: AuthRepository.readid()));
                          },
                        ),
                        Container(
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
            visible: !RootScreen.isMobile(context),
            child: const VerticalDivider()),
        Visibility(
            visible: !RootScreen.isMobile(context),
            child: const SizedBox(width: 350, child: SearchScreen())),
      ],
    );
  }
}

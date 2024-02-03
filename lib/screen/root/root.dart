import 'package:danter/screen/home/home_screen.dart';

import 'package:danter/screen/profile/profile_screen.dart';

import 'package:danter/screen/search/search_screen/search_screen.dart';

import 'package:danter/screen/write/write_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int homeindex = 0;
const int searchindex = 1;
const int writeindex = 2;

const int profileindex = 3;

class RootScreen extends StatefulWidget {
  const RootScreen({
    super.key,
  });

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeindex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _writeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeindex: _homeKey,
    searchindex: _searchKey,
    writeindex: _writeKey,
    profileindex: _profileKey,
  };

  Future<bool> _onWillpop() async {
    final NavigatorState curentSelectedNavigatorState =
        map[selectedScreenIndex]!.currentState!;

    if (curentSelectedNavigatorState.canPop()) {
      curentSelectedNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return WillPopScope(
        onWillPop: _onWillpop,
        child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeindex, const HomeScreen()),
              _navigator(_searchKey, searchindex, const SearchScreen()),
              _navigator(_writeKey, writeindex, const WriteScreen()),
              _navigator(_profileKey, profileindex, const ProfileScreen())
            ],
          ),
          bottomNavigationBar: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              indicatorColor: Colors.transparent,
              destinations: [
                NavigationDestination(
                  icon: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('assets/images/home.png',
                        color: themeData.colorScheme.secondary),
                  ),
                  label: '',
                  selectedIcon: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('assets/images/home_activ (2).png',
                        color: themeData.colorScheme.onPrimary),
                  ),
                ),
                NavigationDestination(
                  icon: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('assets/images/search.png',
                        color: themeData.colorScheme.secondary),
                  ),
                  label: '',
                  selectedIcon: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('assets/images/search.png',
                        color: themeData.colorScheme.onPrimary),
                  ),
                ),
                NavigationDestination(
                  icon: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('assets/images/write (2).png',
                        color: themeData.colorScheme.secondary),
                  ),
                  label: '',
                  selectedIcon: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('assets/images/write (2).png',
                        color: themeData.colorScheme.onPrimary),
                  ),
                ),
                NavigationDestination(
                  icon: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('assets/images/account.png',
                        color: themeData.colorScheme.secondary),
                  ),
                  label: '',
                  selectedIcon: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('assets/images/account-active.png',
                        color: themeData.colorScheme.onPrimary),
                  ),
                ),
              ],
              elevation: 0,
              selectedIndex: selectedScreenIndex,
              shadowColor: Colors.transparent,
              height: 56,

              //    showSelectedLabels: false,
              //    showUnselectedLabels: false,
              backgroundColor: themeData.scaffoldBackgroundColor,
              //     currentIndex: selectedScreenIndex,
              onDestinationSelected: (selectedIndex) {
                setState(() {
                  _history.remove(selectedScreenIndex);
                  _history.add(selectedScreenIndex);
                  selectedScreenIndex = selectedIndex;
                });
              }),
        ));
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (
                context,
              ) =>
                  Offstage(
                      offstage: selectedScreenIndex != index, child: child),
            ),
          );
  }
}

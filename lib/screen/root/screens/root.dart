import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:danter/data/datasource/online_user_datasource.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/bottom_navigattion/screens/bottom_navigattion.dart';
import 'package:danter/screen/Home/screens/home_screen.dart';
import 'package:danter/screen/chatList/screens/chat_list_Screen.dart';
import 'package:danter/screen/profile/screens/profile_screen.dart';
import 'package:danter/screen/root/widgets/button_logout.dart';
import 'package:danter/screen/root/widgets/button_theme.dart';
import 'package:danter/screen/root/widgets/logo_danter.dart';
import 'package:danter/screen/search/search_screen/screens/search_screen.dart';
import 'package:danter/screen/search/search_user/screens/search_user_screen.dart';
import 'package:danter/screen/write/screens/write_screen.dart';
import 'package:flutter/material.dart';

const int homeindex = 0;
const int searchindex = 1;
const int writeindex = 2;
const int chatindex = 3;
const int profileindex = 4;

class RootScreen extends StatefulWidget {
  const RootScreen({
    super.key,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    OnlineUserUatasource(userid: AuthRepository.readid()).online();

    WidgetsBinding.instance
        .addObserver(OnlineUserUatasource(userid: AuthRepository.readid()));
    super.initState();
  }

  int selectedScreenIndex = homeindex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _writeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _chatKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeindex: _homeKey,
    searchindex: _searchKey,
    writeindex: _writeKey,
    chatindex: _chatKey,
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

    return ThemeSwitchingArea(
      child: WillPopScope(
          onWillPop: _onWillpop,
          child: Scaffold(
              key: RootScreen.scaffoldKey,
              drawerScrimColor: Colors.transparent,
              drawer: !RootScreen.isMobile(context)
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: RootScreen.isDesktop(context) ? 170 : 70,
                      ),
                      child: Drawer(
                        elevation: 2,
                        shadowColor:
                            themeData.colorScheme.onSurface.withOpacity(0.5),
                        child: const SearchUserScreen(),
                      ),
                    )
                  : null,
              body: Row(
                children: [
                  Visibility(
                    visible: !RootScreen.isMobile(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const LogoDanter(),
                        Expanded(
                          child: BottomNavigattion(
                            selextedIndex: selectedScreenIndex,
                            onTab: (selectedIndex) {
                              setState(() {
                                _history.remove(selectedScreenIndex);
                                _history.add(selectedScreenIndex);
                                selectedScreenIndex = selectedIndex;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            width: RootScreen.isDesktop(context) ? 150 : 60,
                            height: 0.08,
                            color: themeData.colorScheme.onSecondary,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ButtonThemeCustom(),
                              ButtonLogout(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: !RootScreen.isMobile(context),
                      child: const VerticalDivider(width: 1)),
                  Expanded(
                    child: IndexedStack(
                      index: selectedScreenIndex,
                      children: [
                        _navigator(_homeKey, homeindex, const HomeScreen()),
                        _navigator(
                            _searchKey, searchindex, const SearchScreen()),
                        _navigator(_writeKey, writeindex, const WriteScreen()),
                        _navigator(_chatKey, chatindex, const ChatListScreen()),
                        _navigator(
                            _profileKey,
                            profileindex,
                            const ProfileScreen(
                              namePage: 'RootScreen',
                            ))
                      ],
                    ),
                  )
                ],
              ),
              bottomNavigationBar: RootScreen.isMobile(context)
                  ? NavigationBar(
                      labelBehavior:
                          NavigationDestinationLabelBehavior.alwaysHide,
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
                            child: Image.asset(
                                'assets/images/home_activ (2).png',
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
                            child: Image.asset('assets/images/message.png',
                                color: themeData.colorScheme.secondary),
                          ),
                          label: '',
                          selectedIcon: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset(
                                'assets/images/message_activ.png',
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
                            height: 23,
                            width: 23,
                            child: Image.asset(
                                'assets/images/account-active.png',
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
                      })
                  : null)),
    );
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

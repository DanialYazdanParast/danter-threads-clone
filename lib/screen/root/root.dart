
import 'package:danter/di/di.dart';
import 'package:danter/screen/home/home_screen.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/write/write_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int homeindex = 0;
const int cartindex = 1;
const int profileindex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeindex;
  final List<int> _history = [];

  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _cartKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeindex: _homeKey,
    cartindex: _cartKey,
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
  void dispose() {
   profileBloc.close();
    super.dispose();
  }


final profileBloc = ProfileBloc(locator.get());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillpop,
      child: Scaffold(
        body: IndexedStack(
          index: selectedScreenIndex,
          children: [
            _navigator(_homeKey, homeindex, const HomeScreen()),

 //----------------------------------           
            BlocProvider.value(
              value: profileBloc,
              child: _navigator(_cartKey, cartindex, WriteScreen()),
            ),
            BlocProvider.value(
              value: profileBloc,
              child:
                  _navigator(_profileKey, profileindex,  const ProfileScreen()),
            ),
  //----------------------------------              
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 26,
                    width: 26,
                    child: Image.asset('assets/images/home.png',
                        color: const Color(0xffB8B8B8)),
                  ),
                  activeIcon: SizedBox(
                    height: 26,
                    width: 26,
                    child: Image.asset(
                      'assets/images/home_activ.png',
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/images/write.png',
                        color: const Color(0xffB8B8B8)),
                  ),
                  activeIcon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset(
                      'assets/images/write_activ.png',
                    ),
                  ),
                  label: ''),
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person, color: Color(0xffB8B8B8)),
                  activeIcon: Icon(CupertinoIcons.person_fill),
                  label: ''),
            ],
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 26,
            backgroundColor: Colors.white,
            currentIndex: selectedScreenIndex,
            onTap: (selectedIndex) {
              setState(() {
                _history.remove(selectedScreenIndex);
                _history.add(selectedScreenIndex);
                selectedScreenIndex = selectedIndex;
              });
            }),
      ),
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

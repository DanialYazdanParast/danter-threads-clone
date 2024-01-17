
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/home/home_screen.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/settings/cubit/them_cubit.dart';
import 'package:danter/screen/write/write_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int homeindex = 0;
const int cartindex = 1;
const int profileindex = 2;

class RootScreen extends StatefulWidget {
   RootScreen({super.key , });


   

 
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
  Widget build(BuildContext context) {
     final ThemeData themeData = Theme.of(context);

   

  
    return WillPopScope(
      onWillPop: _onWillpop,
      child: Scaffold(
        body: IndexedStack(
          index: selectedScreenIndex,
          



          children: [
            _navigator(_homeKey, homeindex,  HomeScreen()),

 //----------------------------------           
            // BlocProvider.value(
            //   value: widget.profileBloc,
            //   child: _navigator(_cartKey, cartindex, WriteScreen()),
            // ),

            _navigator(_cartKey, cartindex, WriteScreen()),
            // BlocProvider(
            //  create: (context) =>   widget.profileBloc..add(ProfileStartedEvent(user: AuthRepository.readid())),
            //   child:
            //       _navigator(_profileKey, profileindex,   ProfileScreen(profileBloc:  widget.profileBloc, )),
            // ),

            _navigator(_profileKey, profileindex,   ProfileScreen( ),)
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
                        color: themeData.colorScheme.secondary
                        ),
                  ),
                  activeIcon: SizedBox(
                    height: 26,
                    width: 26,
                    child: Image.asset(
                      'assets/images/home_activ (2).png',
                        color:  themeData.colorScheme.onPrimary
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                
                  icon: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset('assets/images/write (2).png',
                        color: themeData.colorScheme.secondary
                ),
                  ),
                  activeIcon: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(
                      'assets/images/write (2).png',
                             color:  themeData.colorScheme.onPrimary
                    ),
                  ),
                  label: ''),
               BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person, color: themeData.colorScheme.secondary ,size: 28),
                  activeIcon: Icon(CupertinoIcons.person_fill ,size: 28, color:  themeData.colorScheme.onPrimary,),
                  label: ''),
            ],
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
             //     iconSize: 28,
             
        
     //   type: BottomNavigationBarType.fixed,
        
             
            backgroundColor:
             themeData.scaffoldBackgroundColor,
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

import 'package:danter/screen/bottom_navigattion/widgets/bottom_navigation_item.dart';
import 'package:danter/screen/bottom_navigattion/widgets/write_dialog.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

class BottomNavigattion extends StatelessWidget {
  final Function(int index) onTab;
  final int selextedIndex;
  const BottomNavigattion(
      {super.key, required this.onTab, required this.selextedIndex});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Column(
      children: [
        BottomNavigationItem(
          iconFileName: 'home.png',
          activeiconFileName: 'home_activ (2).png',
          titel: 'Home',
          onTap: () {
            onTab(homeindex);
          },
          isActive: selextedIndex == homeindex,
        ),
        BottomNavigationItem(
            iconFileName: 'search.png',
            activeiconFileName: 'search.png',
            onTap: () {
              RootScreen.scaffoldKey.currentState?.openDrawer();
            },
            isActive: selextedIndex == searchindex,
            titel: 'Search'),
        BottomNavigationItem(
            iconFileName: 'write (2).png',
            activeiconFileName: 'write (2).png',
            onTap: () {
              showDialog(
                barrierColor:
                    themeData.colorScheme.onSecondary.withOpacity(0.2),
                context: context,
                builder: (context) {
                  return Visibility(
                    visible: !RootScreen.isMobile(context),
                    child: WriteDialog(onTab: onTab),
                  );
                },
              );
            },
            isActive: selextedIndex == writeindex,
            titel: 'Write'),
        BottomNavigationItem(
            iconFileName: 'message.png',
            activeiconFileName: 'message_activ.png',
            onTap: () {
              onTab(chatindex);
            },
            isActive: selextedIndex == chatindex,
            titel: 'Messages'),
        BottomNavigationItem(
            iconFileName: 'account.png',
            activeiconFileName: 'account-active.png',
            onTap: () {
              onTab(profileindex);
            },
            isActive: selextedIndex == profileindex,
            titel: 'Profile'),
      ],
    );
  }
}

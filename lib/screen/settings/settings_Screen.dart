import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:danter/core/constants/theme.dart';
import 'package:danter/main.dart';
import 'package:danter/screen/auth/auth.dart';
import 'package:danter/screen/settings/cubit/them_cubit.dart';
import 'package:danter/config/theme/theme.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/auth_repository.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var darktheme = MyAppThemeConfig.dark().getThemedark();
    var lighttheme = MyAppThemeConfig.light().getThemelight();

    final ThemeData themeData = Theme.of(context);
    return ThemeSwitchingArea(
      child: Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Theme',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w400)),
                    ThemeSwitcher(
                      clipper: const ThemeSwitcherCircleClipper(),
                      builder: (context) {
                        return CupertinoSwitch(
                          activeColor: themeData.colorScheme.secondary,
                          value: ThemeSave.getTheme(),
                          onChanged: (isDarkModeEnabled) {
                            final brightness =
                                ThemeModelInheritedNotifier.of(context)
                                    .theme
                                    .brightness;

                            ThemeSwitcher.of(context).changeTheme(
                              theme: brightness == Brightness.light
                                  ? darktheme
                                  : lighttheme,
                              isReversed:
                                  brightness == Brightness.light ? true : false,
                            );
                            ThemeSave.setTheme(
                                brightness == Brightness.light ? true : false);
                          },
                        );
                      },
                    ),
                  ],
                ),
                Divider(
                    height: 10,
                    color: themeData.colorScheme.secondary.withOpacity(0.5),
                    thickness: 0.7),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                      onTap: () {
                        AuthRepository.logout();

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AuthScreen(),
                        ));
                      },
                      child: Text(
                        'Log out',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}

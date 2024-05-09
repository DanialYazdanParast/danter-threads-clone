import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:danter/config/theme/theme.dart';
import 'package:danter/core/constants/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeSwitcherDetaile extends StatelessWidget {
  const ThemeSwitcherDetaile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var darktheme = MyAppThemeConfig.dark().getThemedark();
    var lighttheme = MyAppThemeConfig.light().getThemelight();

    final ThemeData themeData = Theme.of(context);
    return ThemeSwitcher(
      clipper: const ThemeSwitcherCircleClipper(),
      builder: (context) {
        return Transform.scale(
          scale: 0.9,
          child: CupertinoSwitch(
            activeColor: themeData.colorScheme.secondary,
            value: ThemeSave.getTheme(),
            onChanged: (isDarkModeEnabled) {
              final brightness =
                  ThemeModelInheritedNotifier.of(context).theme.brightness;

              ThemeSwitcher.of(context).changeTheme(
                theme: brightness == Brightness.light ? darktheme : lighttheme,
                isReversed: brightness == Brightness.light ? true : false,
              );
              ThemeSave.setTheme(brightness == Brightness.light ? true : false);
            },
          ),
        );
      },
    );
  }
}

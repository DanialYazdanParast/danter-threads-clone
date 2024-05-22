import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:danter/config/theme/theme.dart';
import 'package:danter/core/constants/theme.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

class ButtonThemeCustom extends StatelessWidget {
  const ButtonThemeCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    var darktheme = MyAppThemeConfig.dark().getThemedark();
    var lighttheme = MyAppThemeConfig.light().getThemelight();
    return ThemeSwitcher(
      clipper: const ThemeSwitcherCircleClipper(),
      builder: (context) {
        return SizedBox(
          width: RootScreen.isDesktop(context) ? 160 : 65,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(40, 55),

                shape: RootScreen.isDesktop(context)
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                    : const CircleBorder(),

                //  CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              onPressed: () {
                ThemeSwitcher.of(context).changeTheme(
                  theme:
                      brightness == Brightness.light ? darktheme : lighttheme,
                  isReversed: brightness == Brightness.light ? true : false,
                );
                ThemeSave.setTheme(
                    brightness == Brightness.light ? true : false);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                      brightness == Brightness.dark
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      size: 22,
                      color: Colors.orange),
                  Visibility(
                    visible: RootScreen.isDesktop(context) ? true : false,
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            brightness == Brightness.dark
                                ? 'Dark mode'
                                : 'Light mode',
                            style: themeData.textTheme.titleLarge!.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

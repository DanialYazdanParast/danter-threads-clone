import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:danter/screen/auth/screens/auth.dart';
import 'package:danter/screen/settings/widgets/theme_switcher_detaile.dart';
import 'package:flutter/material.dart';
import '../../../data/repository/auth_repository.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const ThemeSwitcherDetaile(),
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
                          builder: (context) => const AuthScreen(),
                        ));
                      },
                      child: Text(
                        'Log out',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}

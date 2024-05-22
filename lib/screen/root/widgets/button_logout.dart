import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/auth/screens/auth.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

class ButtonLogout extends StatelessWidget {
  const ButtonLogout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: RootScreen.isDesktop(context) ? 160 : 65,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(40, 55),
            backgroundColor: themeData.colorScheme.onBackground,

            shape: RootScreen.isDesktop(context)
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
                : const CircleBorder(),

            //  CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          onPressed: () {
            AuthRepository.logout();

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const AuthScreen(),
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: RootScreen.isTablet(context),
                  child: const Icon(Icons.logout, size: 22)),
              Visibility(
                visible: RootScreen.isDesktop(context) ? true : false,
                child: Center(
                  child: Text(
                    'Log out',
                    style: themeData.textTheme.titleLarge!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w100),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/auth/screens/auth.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                fontWeight: FontWeight.w400, color: Colors.red, fontSize: 14),
          )),
    );
  }
}

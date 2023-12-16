
import 'package:danter/main.dart';

import 'package:flutter/material.dart';

import '../../data/repository/auth_repository.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {
                  AuthRepository.logout();

                  Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return const MyApp();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(fontSize: 16),
                )),
            const Divider()
          ],
        ));
  }
}

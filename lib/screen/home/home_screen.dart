import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/auth/auth.dart';
import 'package:danter/widgets/postlist.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            title: SizedBox(
              height: 40,
              width: 40,
              child: GestureDetector(
                onTap: () {
                  AuthRepository.logout();

                  Navigator.of(context ,rootNavigator: true).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthScreen();
                    },
                  ),
                );
                },
                child: Image.asset(
                  'assets/images/d.png',
                ),
              ),
            ),
            centerTitle: true,
          ),
          SliverList.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return const PostList();
            },
          ),
        ],
      ),
    );
  }
}

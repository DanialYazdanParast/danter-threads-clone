import 'package:danter/core/widgets/logo.dart';
import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: false,
      title: Logo(size: 40),
      centerTitle: true,
    );
  }
}

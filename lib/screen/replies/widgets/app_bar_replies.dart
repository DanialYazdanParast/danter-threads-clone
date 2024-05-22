import 'package:flutter/material.dart';

class AppBarReplies extends StatelessWidget {
  const AppBarReplies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Danter'),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Divider(
              height: 1,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              thickness: 0.7)),
    );
  }
}

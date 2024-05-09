import 'package:danter/data/model/user.dart';
import 'package:flutter/material.dart';

class NameProfileUser extends StatelessWidget {
  const NameProfileUser({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Text(
      user.name == '' ? user.username : '${user.name}',
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(overflow: TextOverflow.clip),
    );
  }
}

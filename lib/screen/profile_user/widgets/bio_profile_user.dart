import 'package:danter/data/model/user.dart';
import 'package:flutter/material.dart';

class BioProfileUser extends StatelessWidget {
  const BioProfileUser({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: user.bio!.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          '${user.bio}',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.2),
        ),
      ),
    );
  }
}

import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class NameProfile extends StatelessWidget {
  NameProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Text(
        (AuthRepository.loadAuthInfo()!.name.isEmpty)
            ? AuthRepository.loadAuthInfo()!.username
            : AuthRepository.loadAuthInfo()!.name,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(overflow: TextOverflow.clip),
      ),
    );
  }
}

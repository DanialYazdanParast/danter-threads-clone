import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class BioProfile extends StatelessWidget {
  const BioProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: AuthRepository.loadAuthInfo()!.bio!.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          AuthRepository.loadAuthInfo()!.bio!,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.2),
        ),
      ),
    );
  }
}

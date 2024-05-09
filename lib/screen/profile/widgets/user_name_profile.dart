import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class UserNameProfile extends StatelessWidget {
  const UserNameProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        Text(
          AuthRepository.loadAuthInfo()!.username,
          style: themeData.textTheme.labelLarge!.copyWith(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: themeData.colorScheme.onBackground,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Text(
                'danter.net',
                style: themeData.textTheme.titleSmall!.copyWith(
                  fontSize: 10,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ButtonProfile extends StatelessWidget {
  final User user;
  const ButtonProfile({
    super.key,
    required this.onTabfollow,
    required this.user,
  });

  final GestureTapCallback onTabfollow;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Expanded(
      child: SizedBox(
        height: 34,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor:
                    user.followers.contains(AuthRepository.readid())
                        ? themeData.scaffoldBackgroundColor
                        : themeData.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: onTabfollow,
            child: Text(
                user.followers.contains(AuthRepository.readid())
                    ? 'Following'
                    : 'Follow',
                style: user.followers.contains(AuthRepository.readid())
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w400)
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: themeData.scaffoldBackgroundColor,
                        fontWeight: FontWeight.w400))),
      ),
    );
  }
}

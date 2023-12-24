import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/theme.dart';

import 'package:danter/widgets/image_user_post.dart';

import 'package:flutter/material.dart';


class LikedDetailScreen extends StatelessWidget {
  final User user;
  final GestureTapCallback onTabProfile;
  final GestureTapCallback onTabFollow;
  const LikedDetailScreen(
      {super.key,
      required this.user,
      required this.onTabProfile,
      required this.onTabFollow});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTabProfile,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageUserPost(user: user, onTabNameUser: onTabProfile),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(user.name == '' ? user.username : user.name!,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: user.id != AuthRepository.readid(),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(100, 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: onTabFollow,
                  child: Text(
                    user.followers.contains(AuthRepository.readid())
                        ? 'Following'
                        : 'Follow',
                    style: TextStyle(
                        color: user.followers.contains(AuthRepository.readid())
                            ? LightThemeColors.secondaryTextColor
                            : Colors.black),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

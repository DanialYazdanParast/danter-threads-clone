import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/image_user_post.dart';
import 'package:flutter/material.dart';


class FollowersPage extends StatelessWidget {
  final String userid;
  final User userFollowers;
  final GestureTapCallback onTabProfileUser;
  final GestureTapCallback onTabfolow;
  const FollowersPage({
    super.key,
    required this.userFollowers,
    required this.userid,
    required this.onTabProfileUser, required this.onTabfolow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTabProfileUser,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageUserPost(user: userFollowers, onTabNameUser: onTabProfileUser),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userFollowers.username,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  userFollowers.name == ''
                      ? userFollowers.username
                      : userFollowers.name!,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: userFollowers.id != AuthRepository.readid(),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(100, 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed:onTabfolow,
                  child: Text(
                    userid == AuthRepository.readid()
                        ? 'Remove'
                        : userFollowers.followers
                                .contains(AuthRepository.readid())
                            ? 'Following'
                            : 'Follow',
                    style: TextStyle(
                      color: userid == AuthRepository.readid()
                          ? Colors.black
                          : userFollowers.followers
                                  .contains(AuthRepository.readid())
                              ? LightThemeColors.secondaryTextColor
                              : Colors.black,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

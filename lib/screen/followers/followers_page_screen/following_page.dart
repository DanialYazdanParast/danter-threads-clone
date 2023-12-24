import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/image_user_post.dart';
import 'package:flutter/material.dart';

class FollowingPage extends StatelessWidget {
  final String userid;
  final User userFollowing;
      final GestureTapCallback onTabProfileUser;
      final GestureTapCallback onTabfolow;
  const FollowingPage({
    super.key,
    required this.userFollowing,
    required this.userid, required this.onTabProfileUser, required this.onTabfolow,
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
              onTap: onTabProfileUser,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, left: 15, right: 15, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageUserPost(user: userFollowing ,onTabNameUser: onTabProfileUser,),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userFollowing.username,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          userFollowing.name == ''
                              ? '${userFollowing.username}'
                              : '${userFollowing.name}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Visibility(
                      visible: userFollowing.id !=AuthRepository.readid(),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(100, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed:onTabfolow,
                          child: Text(
                            userFollowing.followers.contains(AuthRepository.readid())
                                    ? 'Following'
                                    : 'Follow',
                            style: TextStyle(
                              color:userFollowing.id== AuthRepository.readid()
                                  ? LightThemeColors.secondaryTextColor
                                  :  userFollowing.followers.contains(AuthRepository.readid())
                                      ? LightThemeColors.secondaryTextColor
                                      :Colors.black,
                                       
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            );
  }
}

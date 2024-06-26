import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/widgets/image_user_post.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

class UserDetailFollow extends StatelessWidget {
  final User user;
  final GestureTapCallback onTabProfile;
  final GestureTapCallback onTabFollow;
  final String? namePage;
  const UserDetailFollow(
      {super.key,
      required this.user,
      required this.onTabProfile,
      required this.onTabFollow,
      this.namePage = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabProfile,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageUserPost(user: user, onTabNameUser: onTabProfile),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: !RootScreen.isMobile(context) &&
                                namePage != '' &&
                                user.id != AuthRepository.readid()
                            ? 130
                            : !RootScreen.isMobile(context) && namePage == ''
                                ? 90
                                : null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              user.username,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(),
                            ),
                            const SizedBox(width: 2),
                            Visibility(
                              visible: user.tik,
                              child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: Image.asset('assets/images/tik.png')),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: !RootScreen.isMobile(context) &&
                                namePage != '' &&
                                user.id != AuthRepository.readid()
                            ? 130
                            : !RootScreen.isMobile(context) && namePage == ''
                                ? 90
                                : null,
                        child: Text(
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            user.name == '' ? user.username : user.name!,
                            style: Theme.of(context).textTheme.titleSmall),
                      )
                    ],
                  ),
                  const Spacer(),
                  Visibility(
                    visible: user.id != AuthRepository.readid(),
                    child: SizedBox(
                      height: 35,
                      width: 130,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            // minimumSize: const Size(120, 35),
                            // maximumSize: Size(120, 35),
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        onPressed: onTabFollow,
                        child: Text(
                          user.followers.contains(AuthRepository.readid())
                              ? 'Following'
                              : 'Follow',
                          style:
                              user.followers.contains(AuthRepository.readid())
                                  ? Theme.of(context).textTheme.titleSmall
                                  : Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 67),
              child: Divider(
                height: 20,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                thickness: 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:danter/core/widgets/image.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class ReplyTo extends StatelessWidget {
  const ReplyTo({
    super.key,
    required this.postEntity,
    required this.onTabNavigator,
  });

  final PostEntity postEntity;
  final GestureTapCallback onTabNavigator;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      height: 60,
      color: themeData.scaffoldBackgroundColor,
      child: Bounce(
        duration: const Duration(milliseconds: 180),
        onPressed: onTabNavigator,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: themeData.colorScheme.onBackground, //Color(0xffF1A1A1A),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  (AuthRepository.loadAuthInfo()!.avatarchek.isNotEmpty)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox(
                              height: 24,
                              width: 24,
                              child: ImageLodingService(
                                  imageUrl:
                                      AuthRepository.loadAuthInfo()!.avatar)),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                              height: 24,
                              width: 24,
                              color: themeData.colorScheme.secondary,
                              child: Image.asset('assets/images/profile.png')),
                        ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Reply to ${postEntity.user.username}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(height: 2.8)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

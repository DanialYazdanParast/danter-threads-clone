import 'package:danter/core/extensions/global_extensions.dart';
import 'package:danter/core/widgets/image_user_post.dart';
import 'package:danter/data/model/messageslist.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ChatListDetail extends StatelessWidget {
  final MessagesList messages;
  final GestureTapCallback onTabProfile;
  final GestureTapCallback onTabFollow;
  const ChatListDetail({
    super.key,
    required this.onTabProfile,
    required this.onTabFollow,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final User user = messages.usersend.id == AuthRepository.readid()
        ? messages.usersseen
        : messages.usersend;

    return GestureDetector(
      onTap: onTabProfile,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageUserPost(
                      user: user, onTabNameUser: onTabProfile, size: 44),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(user.username,
                              style: Theme.of(context).textTheme.titleLarge),
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
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(messages.text,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: Theme.of(context).textTheme.titleSmall),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(messages.created.time(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 13))
                ],
              ),
            ),
            //  SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 67),
              child: Divider(
                  height: 20,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  thickness: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

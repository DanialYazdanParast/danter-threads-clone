import 'package:danter/core/extensions/global_extensions.dart';
import 'package:danter/core/widgets/image_user_post.dart';
import 'package:danter/data/model/messageslist.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail({
    super.key,
    required this.user,
    required this.response,
  });
  final List<MessagesList> response;
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: response.length,
      itemBuilder: (context, index) {
        bool trueusersend =
            response[index].usersend.id == AuthRepository.readid();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              trueusersend ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: index == 0 ? 66 : 0),
              child: Visibility(
                visible: !trueusersend,
                child:
                    ImageUserPost(user: user, onTabNameUser: () {}, size: 30),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(4, 4, 10, index == 0 ? 66 : 0),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.66),
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  color: response[index].usersend.id == AuthRepository.readid()
                      ?
                      //Theme.of(context).colorScheme.onBackground,
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.8)
                      : Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    bottomLeft: trueusersend
                        ? const Radius.circular(15)
                        : const Radius.circular(0),
                    topRight: const Radius.circular(15),
                    bottomRight: trueusersend
                        ? const Radius.circular(0)
                        : const Radius.circular(15),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    response[index].usersend.id == AuthRepository.readid()
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  Text(response[index].text,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18,
                          height: 1.4,
                          color: response[index].usersend.id ==
                                  AuthRepository.readid()
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.onPrimary)),
                  Text(response[index].created.time(),
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 12,
                          height: 1.4,
                          color: response[index].usersend.id ==
                                  AuthRepository.readid()
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.onPrimary))
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

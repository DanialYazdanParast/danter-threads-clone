import 'package:danter/core/extensions/global_extensions.dart';
import 'package:danter/core/widgets/image_user_post.dart';
import 'package:danter/core/widgets/time.dart';
import 'package:danter/data/model/post.dart';
import 'package:flutter/material.dart';

class ImageAndNameAndText extends StatelessWidget {
  const ImageAndNameAndText({
    super.key,
    required this.postEntity,
    required this.onTabNameUser,
    required this.onTabmore,
    this.replypage = false,
  });

  final PostEntity postEntity;
  final GestureTapCallback onTabNameUser;
  final GestureTapCallback onTabmore;
  final bool replypage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //----------------------ImageUserPost----------------------//
          ImageUserPost(user: postEntity.user, onTabNameUser: onTabNameUser),
          //----------------------ImageUserPost----------------------//

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: postEntity.text.textdirection()
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onTabNameUser,
                        child: Text(
                          postEntity.user.username,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(width: 2),

                      Visibility(
                        visible: postEntity.user.tik,
                        child: GestureDetector(
                          onTap: onTabNameUser,
                          child: SizedBox(
                              width: 16,
                              height: 16,
                              child: Image.asset('assets/images/tik.png')),
                        ),
                      ),

                      const Spacer(),
                      //TimePost
                      TimePost(created: postEntity.created),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: onTabmore,
                        child: Icon(
                          Icons.more_horiz,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.7),
                          size: 24,
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: postEntity.postid.isNotEmpty && replypage == true,
                    child: Text('Replying to @${postEntity.postiduser}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 14)),
                  ),
                  Directionality(
                    textDirection: postEntity.text.textdirection()
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: postEntity.text != ''
                        ? Text(postEntity.text,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(height: 1.2))
                        : const SizedBox(),
                  ),
                  SizedBox(
                    height: postEntity.text == '' ? 0 : 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

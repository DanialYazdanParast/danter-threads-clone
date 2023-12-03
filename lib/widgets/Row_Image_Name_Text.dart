
import 'package:danter/data/model/post.dart';
import 'package:danter/widgets/image_user_post.dart';
import 'package:danter/widgets/time.dart';

import 'package:flutter/material.dart';

class ImageAndNameAndText extends StatelessWidget {
  const ImageAndNameAndText({
    super.key,
    required this.postEntity, required this.onTabNameUser,required this.onTabmore
  });
 
  final PostEntity postEntity;
    final GestureTapCallback onTabNameUser;
    final GestureTapCallback onTabmore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //----------------------ImageUserPost----------------------//
          ImageUserPost(user: postEntity.user,onTabNameUser: onTabNameUser),
          //----------------------ImageUserPost----------------------//

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap:onTabNameUser ,
                        child: Text(
                          postEntity.user.username,
                          style: Theme.of(context).textTheme.headline6,
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
                          color: Colors.black87.withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 7),
                    child: Text(
                      postEntity.text,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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

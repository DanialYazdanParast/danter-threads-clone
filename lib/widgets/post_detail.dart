import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/image/image_screen.dart';
import 'package:danter/screen/likes/likes_Screen.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/profile/profile_screen.dart';
import 'package:danter/screen/profile_user/profile_user.dart';
import 'package:danter/screen/replies/replies_screen.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/Row_Image_Name_Text.dart';
import 'package:danter/widgets/image.dart';
import 'package:danter/widgets/photoUserFollowers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetail extends StatelessWidget {
  final PostEntity postEntity;

  final GestureTapCallback onTabmore;
  final GestureTapCallback onTabLike;

  const PostDetail({
    super.key,
    required this.postEntity,
   
    required this.onTabmore,
    required this.onTabLike,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => RepliesScreen(
            postEntity: postEntity,
          ),
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 33,
              top: 65,
              bottom: 54,
              child: Container(
                width: postEntity.replies.length > 0 ? 1 : 0,
                color: LightThemeColors.secondaryTextColor,
              ),
            ),
            Column(
              children: [
                ImageAndNameAndText(
                    postEntity: postEntity,
                   
                                onTabNameUser: () {
                    if (postEntity.user.id == AuthRepository.readid()) {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => ProfileBloc(locator.get()),
                              child: ProfileScreen(
                                  profileBloc: ProfileBloc(locator.get())),
                            );
                          },
                        ),
                      );
                    } else {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfileUser(
                              user: postEntity.user,
                            );
                          },
                        ),
                      );
                    }
             
                    },
                    onTabmore: onTabmore),
                postEntity.image.isNotEmpty && postEntity.image.length < 2
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 65, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => ImageScreen(
                                image:
                                    'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[0]}',
                              ),
                            ));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                child: ImageLodingService(
                                  imageUrl:
                                      'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[0]}',
                                ),
                              )),
                        ),
                      )
                    : postEntity.image.length > 1
                        ? SizedBox(
                            height: 260,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: postEntity.image.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 10,
                                        left: (index == 0) ? 65 : 10,
                                        right: (index ==
                                                postEntity.image.length - 1)
                                            ? 10
                                            : 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                        width: 200,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(MaterialPageRoute(
                                              builder: (context) => ImageScreen(
                                                image:
                                                    'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[index]}',
                                              ),
                                            ));
                                          },
                                          child: ImageLodingService(
                                            imageUrl:
                                                'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[index]}',
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          )
                        : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 65),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: onTabLike,
                        child: Container(
                          child:
                              postEntity.likes.contains(AuthRepository.readid())
                                  ? const Icon(CupertinoIcons.heart_fill,
                                      color: Colors.red, size: 24)
                                  : const Icon(
                                      CupertinoIcons.heart,
                                      size: 24,
                                    ),
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context, rootNavigator: true)
                          //     .push(MaterialPageRoute(
                          //   builder: (context) =>
                          //       WriteReply(postEntity: postEntity),
                          // ));
                        },
                        child: SizedBox(
                          height: 22,
                          width: 22,
                          child: Image.asset(
                            'assets/images/comments.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      postEntity.replies.length > 1
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                (postEntity
                                        .replies[0].avatarchek.isNotEmpty)
                                    ? ImageReplyUser(
                                        photo:
                                            postEntity.replies[0].avatar,
                                      )
                                    : const PhotoReplyUserNoPhoto(),
                                Positioned(
                                  left: 13,
                                  bottom: 0,
                                  child: (postEntity.replies[1].avatarchek
                                          .isNotEmpty)
                                      ? ImageReplyUser(
                                          photo:
                                              postEntity.replies[1].avatar,
                                        )
                                      : const PhotoReplyUserNoPhoto(),
                                )
                              ],
                            )
                          : postEntity.replies.length == 1
                              ? Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: (postEntity.replies[0].avatarchek
                                          .isNotEmpty)
                                      ? ImageReplyUser(
                                          photo:
                                              postEntity.replies[0].avatar,
                                        )
                                      : const PhotoReplyUserNoPhoto(),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(left: 30),
                                ),
                      SizedBox(width: postEntity.replies.length > 1 ? 30 : 22),
                      Visibility(
                        visible: postEntity.replies.isNotEmpty,
                        child: Row(
                          children: [
                            Text(postEntity.replies.length.toString(),
                                style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(width: 6),
                            Text(
                                postEntity.replies.length <= 1
                                    ? 'reply'
                                    : 'replies',
                                style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(width: 18),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: postEntity.likes.isNotEmpty,
                        child: Row(
                          children: [
                            Text(postEntity.likes.length.toString(),
                                style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                  builder: (context) => LikesScreen(
                                    idpostEntity: postEntity.id,
                                  ),
                                ));
                              },
                              child: Text(
                                  postEntity.likes.length <= 1
                                      ? 'Like'
                                      : 'Likes',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/widgets/image.dart';
import 'package:danter/core/widgets/image_post.dart';
import 'package:danter/data/model/post.dart';
import 'package:flutter/material.dart';

class PostWrite extends StatelessWidget {
  final PostEntity postEntity;
  final String namePage;
  const PostWrite({
    super.key,
    required this.postEntity,
    required this.namePage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
              left: 28,
              top: 53,
              bottom: 0,
              child: Container(
                width: 1,
                color: LightThemeColors.secondaryTextColor,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (postEntity.user.avatarchek.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: ImageLodingService(
                                    imageUrl: postEntity.user.avatar)),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child:
                                    Image.asset('assets/images/profile.png')),
                          ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  postEntity.user.username,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(width: 2),
                                Visibility(
                                  visible: postEntity.user.tik,
                                  child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child:
                                          Image.asset('assets/images/tik.png')),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7, right: 7),
                              child: Text(
                                postEntity.text,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ImagePost(postEntity: postEntity, namepage: namePage),
            ],
          ),
        ],
      ),
    );
  }
}

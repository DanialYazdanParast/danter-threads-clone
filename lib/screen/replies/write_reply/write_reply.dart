
import 'package:danter/data/model/post.dart';
import 'package:danter/widgets/image.dart';
import 'package:danter/widgets/write.dart';
import 'package:danter/theme.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class WriteReply extends StatelessWidget {
  final PostEntity postEntity;
  WriteReply({super.key,required this.postEntity});
  final TextEditingController _controller = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Reply'), elevation: 0.5),
        body:  Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          top: 0,
          right: 0,
          left: 0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                  PostWrite(postEntity: postEntity),
                FildWrite(controller: _controller),
              ],
            ),
          ),
        ),
        
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SendPostWrite(),
        )
      ],
    ),);
  }
}


class PostWrite extends StatelessWidget {
   final PostEntity postEntity;
  const PostWrite({
    super.key, required this.postEntity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     (postEntity.user.avatarchek.isNotEmpty)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                    height: 47,
                                    width: 47,
                                    child: ImageLodingService(
                                        imageUrl: postEntity.user.avatar)),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height: 47,
                                  width: 47,
                                  color: LightThemeColors.secondaryTextColor
                                      .withOpacity(0.4),
                                  child: const Icon(
                                    CupertinoIcons.person_fill,
                                    color: Colors.white,
                                    size: 55,
                                  ),
                                ),
                              ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postEntity.user.username,
                              style:
                                  Theme.of(context).textTheme.headline6,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 7, right: 7),
                              child: Text(
                                postEntity.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

           Positioned(
              left: 33,
              top: 75,
              bottom: 0,
              child: Container(
                width: 1,
                color: LightThemeColors.secondaryTextColor,
              )),
        ],
      ),
    );
  }
}

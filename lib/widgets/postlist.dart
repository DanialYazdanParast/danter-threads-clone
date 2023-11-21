import 'package:danter/screen/replies/replies_screen.dart';
import 'package:danter/screen/replies/write_reply.dart';
import 'package:danter/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  const PostList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: SizedBox(
                            width: 47,
                            height: 47,
                            child: Image.asset(
                              'assets/images/me.jpg',
                            ),
                          ),
                        ),
                        Container(
                          width: 5,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12 ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Daniel',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const Spacer(),
                                Text(
                                  '33m',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),

                                Icon(
                                  Icons.more_horiz,
                                  color: Colors.black87.withOpacity(0.8),
                                )
                                // Text('---',
                                //     style: Theme.of(context).textTheme.subtitle2),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, right: 7),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context,rootNavigator: true)
                                          .push(MaterialPageRoute(
                                        builder: (context) => RepliesScreen(),
                                      ));
                                    },
                                    child: Text(
                                      'Daniekkjhhhhhhhhhhhkkkkgggggggggggggggggggggggggggggggggggggggggggggggggggggggkkkkkgggggggggggggggggggggggggggggggggggggggggkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkhhhhjjjjjjjjjjjjjjjjjjjjjjjjjjjhhhhhhhhhhhhhkkkl',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(CupertinoIcons.heart,
                                          size: 24),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context,rootNavigator: true)
                                          .push(MaterialPageRoute(
                                        builder: (context) => WriteReply(),
                                      ));
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '26',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'replies',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      Text(
                                        '112',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'likes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color(0xff999999),
                height: 20,
              ),
            ],
          ),
          Positioned(
              left: 33,
              top: 75,
              bottom: 54,
              child: Container(
                width: 1,
                color: LightThemeColors.secondaryTextColor,
              )),
          const Positioned(left: 17, bottom: 22, child: PhotoUserReply()),
        ],
      ),
    );
  }
}

class PhotoUserReply extends StatelessWidget {
  const PhotoUserReply({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
            child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 2, color: Colors.white)),
        )),
        Positioned(
          left: 13,
          bottom: 0,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.white)),
          ),
        )
      ],
    );
  }
}

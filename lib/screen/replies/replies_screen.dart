import 'package:danter/screen/replies/write_reply.dart';
import 'package:danter/widgets/postlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepliesScreen extends StatelessWidget {
  const RepliesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Danter'), elevation: 0.5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ReplyPost(),
              ),
              SliverList.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return const PostList();
                },
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 60))
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                height: 55,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) => WriteReply(),
                        ));
                      },
                      child: Container(
                        color: const Color(0xffF5F5F5),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    'assets/images/me.jpg',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                'Reply to Daniel',
                                style: TextStyle(
                                    color: Color(0xffA1A1A1),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

//-----------ReplyPost-------------//
class ReplyPost extends StatelessWidget {
  const ReplyPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daniekkkkkkkkkkkkkjjjhhhhhkkkl',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.heart, size: 24),
                    const SizedBox(
                      width: 18,
                    ),
                    GestureDetector(
                       onTap: () {
                        Navigator.of(context, rootNavigator: true)
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '26',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      'replies',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      '112',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      'likes',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            color: Color(0xff999999),
            height: 20,
          ),
        ],
      ),
    );
  }
}

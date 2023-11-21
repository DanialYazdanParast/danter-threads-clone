
import 'package:danter/widgets/write.dart';
import 'package:danter/theme.dart';

import 'package:flutter/material.dart';

class WriteReply extends StatelessWidget {
  WriteReply({super.key});
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
                 const PostWrite(),
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
  const PostWrite({
    super.key,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daniel',
                              style:
                                  Theme.of(context).textTheme.headline6,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 7, right: 7),
                              child: Text(
                                'Daniffffffffffffggggggggggggggggffffgggggggggggggggggggggggffffffffffffghhhhhkkkl',
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

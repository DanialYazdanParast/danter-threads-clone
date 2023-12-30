import 'package:danter/data/model/post.dart';
import 'package:danter/theme.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
const  ImageScreen({super.key, required this.postEntity, required this.indeximage});
  final PostEntity postEntity;
  final int indeximage;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
    bool celectmultiply = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  celectmultiply = !celectmultiply;
                });
              },
              child: PageView.builder(
                itemCount: widget.postEntity.image.length,
                clipBehavior: Clip.hardEdge,
                controller: PageController(initialPage:  widget.indeximage),
                itemBuilder: (context, index) {
                  return Hero(
                    tag:  widget.postEntity.image[widget.indeximage],
                    child: ImageLodingService(
                      imageUrl:
                          'https://dan.chbk.run/api/files/6291brssbcd64k6/${widget.postEntity.id}/${widget.postEntity.image[index]}',
                           boxFit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            celectmultiply == true
                ? Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: LightThemeColors.secondaryTextColor
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          CupertinoIcons.multiply,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

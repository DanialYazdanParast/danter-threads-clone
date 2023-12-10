import 'package:danter/theme.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({super.key, required this.image});
  final String image;
  bool celectmultiply = true;
  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
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
                  widget.celectmultiply = !widget.celectmultiply;
                });
              },
              child: Center(
                child: ImageLodingService(
                  imageUrl: widget.image,
                ),
              ),
            ),
            widget.celectmultiply == true
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

import 'package:danter/core/widgets/image.dart';
import 'package:danter/data/model/user.dart';
import 'package:flutter/material.dart';

class ImageProfileUser extends StatelessWidget {
  final User user;
  const ImageProfileUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: (user.avatarchek.isNotEmpty)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                      height: 74,
                      width: 74,
                      child: ImageLodingService(imageUrl: user.avatar)),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                      height: 74,
                      width: 74,
                      child: Image.asset('assets/images/profile.png')),
                ),
        ),
        Positioned(
          bottom: -1,
          left: -1,
          child: Visibility(
            visible: user.tik,
            child: SizedBox(
                width: 27,
                height: 27,
                child: Image.asset(
                  'assets/images/tik.png',
                  color: Theme.of(context).scaffoldBackgroundColor,
                )),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Visibility(
            visible: user.tik,
            child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/images/tik.png')),
          ),
        ),
      ],
    );
  }
}

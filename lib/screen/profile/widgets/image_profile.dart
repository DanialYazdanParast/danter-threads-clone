import 'package:danter/core/widgets/image.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ImageProfile extends StatelessWidget {
  ImageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: (AuthRepository.loadAuthInfo()!.avatarchek.isNotEmpty)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                      height: 74,
                      width: 74,
                      child: ImageLodingService(
                          imageUrl: AuthRepository.loadAuthInfo()!.avatar)),
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
            visible: AuthRepository.loadAuthInfo()!.tik,
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
            visible: AuthRepository.loadAuthInfo()!.tik,
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

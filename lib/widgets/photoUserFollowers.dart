
import 'package:danter/theme.dart';
import 'package:flutter/material.dart';

class PhotoUserFollowers extends StatelessWidget {
  const PhotoUserFollowers({super.key});

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
              color: LightThemeColors.secondaryTextColor,
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
                color: LightThemeColors.secondaryTextColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.white)),
          ),
        )
      ],
    );
  }
}

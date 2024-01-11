import 'package:danter/theme.dart';
import 'package:danter/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class PhotoUserFollowers extends StatelessWidget {
//   const PhotoUserFollowers({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         ClipRRect(
//             child: Container(
//           width: 22,
//           height: 22,
//           decoration: BoxDecoration(
//               color: LightThemeColors.secondaryTextColor,
//               borderRadius: BorderRadius.circular(50),
//               border: Border.all(width: 2, color: Colors.white)),
//         )),
//         Positioned(
//           left: 13,
//           bottom: 0,
//           child: Container(
//             width: 22,
//             height: 22,
//             decoration: BoxDecoration(
//                 color: LightThemeColors.secondaryTextColor,
//                 borderRadius: BorderRadius.circular(50),
//                 border: Border.all(width: 2, color: Colors.white)),
//           ),
//         )
//       ],
//     );
//   }
// }

class ImageReplyUser extends StatelessWidget {
  const ImageReplyUser({
    super.key,
    required this.photo,
  });

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 19,
      width: 19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 1,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      child: ImageLodingService(
        borderRadius: BorderRadius.circular(
          100,
        ),
        imageUrl: photo,
      ),
    );
  }
}

class PhotoReplyUserNoPhoto extends StatelessWidget {
  const PhotoReplyUserNoPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 21,
        width: 21,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 2,
              color: Theme.of(context).scaffoldBackgroundColor,
            )),
        child: Image.asset('assets/images/profile.png'));
  }
}

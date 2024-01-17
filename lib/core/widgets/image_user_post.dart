import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/config/theme/theme.dart';
import 'package:danter/core/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageUserPost extends StatelessWidget {
  final GestureTapCallback onTabNameUser;
  const ImageUserPost({
    super.key,
    required this.user,
    required this.onTabNameUser,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabNameUser,
      child: Container(
          child: (user.avatarchek.isNotEmpty)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                      height: 36,
                      width: 36,
                      child: ImageLodingService(imageUrl: user.avatar)),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                      height: 36,
                      width: 36,
                      child: Image.asset('assets/images/profile.png')),
                )),
    );
  }
}


// ClipRRect(
//                 borderRadius: BorderRadius.circular(100),
//                 child: Container(
//                   height: 47,
//                   width: 47,
//                   color:Theme.of(context).colorScheme.secondary.withOpacity(0.4),
//                   child:  Icon(
//                     CupertinoIcons.person_fill,
//                     color: Theme.of(context).scaffoldBackgroundColor,
//                     size: 55,
//                   ),
//                 ),
//               ),
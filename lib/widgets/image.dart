import 'package:cached_network_image/cached_network_image.dart';
import 'package:danter/theme.dart';
import 'package:flutter/material.dart';

class ImageLodingService extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  final BoxFit?  boxFit ;

  const ImageLodingService({
    required this.imageUrl,
    this.borderRadius,
    super.key, this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Container(color: LightThemeColors.secondaryTextColor.withOpacity(0.5)),
        imageUrl: imageUrl,
        fit: boxFit?? BoxFit.cover,
      ),
    );
  }
}

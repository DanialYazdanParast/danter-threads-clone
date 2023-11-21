import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLodingService extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  const ImageLodingService({
    required this.imageUrl,this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius??BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

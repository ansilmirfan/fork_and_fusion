import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fitHeight,
   
      imageUrl: Constants.image,
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

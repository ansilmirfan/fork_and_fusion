import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/shimmer.dart/shimmer_loading.dart';

class CacheImage extends StatelessWidget {
  final double? width;
  final String url;

  const CacheImage({
    super.key,
    this.width,
    this.url =
        "https://imgs.search.brave.com/36UiHPC4R-fCsU2NXqJIz-9BghaENOxDjpepP76LTSU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA2LzA4Lzg0LzI0/LzM2MF9GXzYwODg0/MjQxM19oZFlhZHA2/dVNDN2M3cHE2TEpl/dzlzOGdQblJTZ2ps/bi5qcGc",
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: width,
      height: width,
      imageUrl: url,
      cacheKey: url,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: ShimmerLoading(
            child: Container(
          color: Colors.grey[50],
          height: double.infinity,
          width: double.infinity,
        )),
      ),
      errorWidget: (context, url, error) {
        log('error from image:$error');
        return const Icon(Icons.error);
      },
    );
  }
}

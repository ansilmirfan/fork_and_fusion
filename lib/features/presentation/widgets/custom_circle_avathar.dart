import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';

class CustomCircleAvathar extends StatelessWidget {
  final String url;
  final double radius;
  const CustomCircleAvathar({
    super.key,
    required this.url,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CacheImage(
          url: url,
        ),
      ),
    );
  }
}

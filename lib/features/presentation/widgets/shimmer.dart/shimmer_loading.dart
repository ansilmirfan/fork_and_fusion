import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fork_and_fusion/features/presentation/widgets/shimmer.dart/sliding_gradiant.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
        colors: const [
          Color.fromARGB(255, 245, 245, 246),
          Color.fromARGB(255, 243, 242, 242),
          Color.fromARGB(255, 221, 221, 222),
        ],
        stops: const [
          0.1,
          0.3,
          0.4,
        ],
        begin: const Alignment(-1.0, -0.0),
        end: const Alignment(1.0, 0.0),
        transform:
            SlidingGradientTransform(slidePercent: _shimmerController.value),
      );
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}

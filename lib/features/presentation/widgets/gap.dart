import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double gap;
  bool vertical;
  Gap({super.key, required this.gap, this.vertical = false});
  factory Gap.width(double width) {
    return Gap(gap: width, vertical: true);
  }

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return SizedBox(width: gap);
    }
    return SizedBox(height: gap);
  }
}

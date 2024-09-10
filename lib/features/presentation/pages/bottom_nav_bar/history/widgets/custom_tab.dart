import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

class CustomTab extends StatelessWidget {
  String text;
  CustomTab({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: Constants.radius,
        ),
        width: Constants.dWidth * 1 / 3,
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}

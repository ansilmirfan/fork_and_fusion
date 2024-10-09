import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  double padding;
  ElevatedContainer({super.key, required this.child, this.padding = 0});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Constants.radius,
      color: Theme.of(context).colorScheme.tertiary,
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}

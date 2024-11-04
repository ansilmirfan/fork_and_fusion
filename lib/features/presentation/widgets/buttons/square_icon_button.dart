import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

class SquareIconButton extends StatelessWidget {
  IconData icon;
  double? height;
  bool white;
  bool loading;
  void Function()? onTap;
  SquareIconButton({
    super.key,
    required this.icon,
    this.height,
    this.loading = false,
    this.onTap,
    this.white = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Constants.radius,
      color: white
          ? Theme.of(context).colorScheme.tertiary
          : Theme.of(context).primaryColor,
      elevation: 10,
      shadowColor: Colors.black,
      child: InkWell(
        borderRadius: Constants.radius,
        splashColor: !white
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).primaryColor,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: loading
              ? CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.tertiary)
              : Icon(
                  icon,
                  size: height,
                  color: white
                      ? Colors.black
                      : Theme.of(context).colorScheme.tertiary,
                ),
        ),
      ),
    );
  }
}

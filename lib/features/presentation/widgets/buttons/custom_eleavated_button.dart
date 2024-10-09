import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';


class CustomEleavatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomEleavatedButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              ContinuousRectangleBorder(borderRadius: Constants.radius)),
          elevation: const WidgetStatePropertyAll(5),
          overlayColor:
              WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary),
          backgroundColor:
              WidgetStatePropertyAll(Theme.of(context).primaryColor),
          foregroundColor:
              WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimary)),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

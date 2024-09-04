import 'package:flutter/material.dart';

class CustomeTextButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  CustomeTextButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: const ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size(double.infinity, 40),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

import 'package:flutter/material.dart';

class CustomeTextButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  bool google;
  Icon? icon;
  CustomeTextButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.google = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            google ? Colors.blue : const Color(0xFFFF6B01),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          minimumSize: const WidgetStatePropertyAll(
            Size(double.infinity, 50),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Visibility(
              visible: google,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'asset/images/google icon.webp',
                    height: 35,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: icon != null,
              child: icon ?? const SizedBox.shrink(),
            ),
            const Spacer(),
            Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  bool google;
  bool progress;
  Icon? icon;
  CustomTextButton(
      {super.key,
      this.text = '',
      this.onPressed,
      this.google = false,
      this.progress = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    bool isEnabled = onPressed != null;
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            isEnabled
                ? google
                    ? Colors.blue
                    : const Color(0xFFFF6B01)
                : Colors.grey,
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
            progress
                ? const CircularProgressIndicator()
                : Text(
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

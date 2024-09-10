import 'package:flutter/material.dart';

class RichLabelText extends StatelessWidget {
  String text1;
  String text2;
  RichLabelText({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}

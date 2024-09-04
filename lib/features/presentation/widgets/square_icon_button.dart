import 'package:flutter/material.dart';

class SquareIconButton extends StatelessWidget {
  Icon icon;
  double height;
  void Function()? onTap;
  SquareIconButton(
      {super.key, required this.icon, this.height = 40, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.black,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: Theme.of(context).primaryColor,
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: height,
          width: height,
          child: icon,
        ),
      ),
    );
  }
}

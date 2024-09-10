import 'package:flutter/material.dart';

import '../../../../../../core/shared/constants.dart';

class SettingsListTile extends StatelessWidget {
  IconData icon;
  String text;
  void Function()? onTap;
  SettingsListTile(
      {super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Theme.of(context).colorScheme.tertiary,
      borderRadius: Constants.radius,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: Constants.radius),
        leading: Icon(icon),
        title: Text(
          text,
        style: Theme.of(context).textTheme.bodyMedium,),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SettingsData {
  static List<IconData> iconData = [
    Icons.shield_outlined,
    Icons.description,
    Icons.favorite_border,
    Icons.phone,
    Icons.info_outline,
    Icons.logout,
  ];
  static List<String> title = [
    'Privacy Policy',
    'Terms of Service',
    'Favorites',
    'Contact Us',
    'About App',
    'Logout'
  ];
  static List<void Function()?> onTap = [
    () {},
    () {},
    () {},
    () {},
    () {},
    () {},
  ];
}

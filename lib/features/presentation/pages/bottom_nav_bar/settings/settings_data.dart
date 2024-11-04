import 'package:flutter/material.dart';

class SettingsData {
  static List<IconData> iconData = [
    Icons.shield_outlined,
    Icons.description,
    Icons.favorite_border,
    Icons.phone,
    Icons.info_outline,
  ];
  static List<String> title = [
    'Privacy Policy',
    'Terms of Service',
    'Favorites',
    'Contact Us',
    'About App',
  ];
  static List<String> navigate = [
    '/privacy policy',
    '/terms of service',
    '/favourite',
    '/contact us',
    '/about the app'
  ];
}

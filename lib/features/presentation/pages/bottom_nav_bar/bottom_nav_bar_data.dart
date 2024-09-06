import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/pages/home/home.dart';

class BottomNavBarData {
  static const primaryColor = Color(0xFFFF6B01);
  static List<BottomBarItem> bottomBarItem = const [
    BottomBarItem(
      inActiveItem: Icon(Icons.home, color: Colors.grey),
      activeItem: Icon(Icons.home, color: primaryColor),
    ),
    BottomBarItem(
      inActiveItem: Icon(Icons.shopping_cart, color: Colors.grey),
      activeItem: Icon(Icons.shopping_cart, color: primaryColor),
    ),
    BottomBarItem(
      inActiveItem: Icon(Icons.history_toggle_off_rounded, color: Colors.grey),
      activeItem: Icon(Icons.history_toggle_off_rounded, color: primaryColor),
    ),
    BottomBarItem(
      inActiveItem: Icon(Icons.settings, color: Colors.grey),
      activeItem: Icon(Icons.settings, color: primaryColor),
    ),
  ];
  static var pages = [
    Home(),
    Center(child: Text("cart")),
    Center(child: Text("history Page")),
    Center(child: Text("Settings Page")),
  ];
}

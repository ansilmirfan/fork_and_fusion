import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/bottom_nav_bar_data.dart';

class BottomNavBar extends StatefulWidget {
  final int currentPage;
  const BottomNavBar({super.key, required this.currentPage});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late final NotchBottomBarController _notchBottomBarController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _notchBottomBarController = NotchBottomBarController();
    _pageController = PageController(initialPage: widget.currentPage); 
    _notchBottomBarController.index = widget.currentPage; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchBottomBarController,
        kIconSize: 24,
        kBottomRadius: 30,
        onTap: (index) {
          setState(() {
            _notchBottomBarController.index = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear);
          });
        },
        bottomBarItems: BottomNavBarData.bottomBarItem,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: BottomNavBarData.pages,
      ),
    );
  }
}

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/bottom_nav_bar_data.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final NotchBottomBarController _notchBottomBarController =
      NotchBottomBarController();

  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    context.read<BottomNavCubit>();
    return Scaffold(
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchBottomBarController,
        kIconSize: 24,
        kBottomRadius: 30,
        onTap: (index) {
          context.read<BottomNavCubit>().onPageChanage(index);
        },
        bottomBarItems: BottomNavBarData.bottomBarItem,
      ),
      body: BlocListener<BottomNavCubit, BottomNavState>(
        listener: (context, state) {
          if (state is BottomNavPageChanageState) {
            _notchBottomBarController.index = state.index;
            _pageController.animateToPage(state.index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear);
            setState(() {});
          }
        },
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: BottomNavBarData.pages,
        ),
      ),
    );
  }
}

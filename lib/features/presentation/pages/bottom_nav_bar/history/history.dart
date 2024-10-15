import 'package:flutter/material.dart';

import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/all.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/custom_tab.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/today.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_appbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/overlay_loading.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    hideLoadingOverlay();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              CustomAppbar(bottom: _buildTabBar(context)),
            ];
          },
          body: const TabBarView(
            children: [
              Today(),
              All(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildTabBar(BuildContext context) {
    return TabBar(
      dividerHeight: 0.0,
      labelColor: Theme.of(context).colorScheme.tertiary,
      indicator: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        borderRadius: Constants.radius,
      ),
      tabs: [
        CustomTab(text: 'Today'),
        CustomTab(text: 'All'),
      ],
    );
  }
}

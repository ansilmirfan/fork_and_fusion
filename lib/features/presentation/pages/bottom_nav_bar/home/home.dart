import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/widgets/carousal.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/widgets/category.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/widgets/custome_item_card.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_appbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter_bottom_sheet.dart';
import 'package:fork_and_fusion/features/presentation/widgets/prodct_listtile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';

class Home extends StatelessWidget {
  Home({super.key});
  RangeValues rangeValues = const RangeValues(0, 1200);

  @override
  Widget build(BuildContext context) {
    var gap = const SizedBox(height: 10);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppbar( scanner: true),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Carousal(height: Constants.dHeight),
                  gap,
                  CustomeItemCard(
                    height: Constants.dHeight,
                    title: 'Special offers',
                  ),
                  gap,
                  CustomeItemCard(
                    height: Constants.dHeight,
                    title: 'Seasonal foods',
                    offer: false,
                  ),
                  gap,
                  CategoryHome(width: Constants.dWidth),
                  _buildTextfield(context),
                  gap,
                ],
              ),
            ),
          ),
          _buildListView(Constants.dHeight),
        ],
      ),
    );
  }

  SliverList _buildListView(double height) {
    return SliverList.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ProductListTile(),
      ),
    );
  }

  _buildTextfield(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: CustomeTextField(
            hintText: 'Search...',
            controller: searchController,
            prefixIcon: const Icon(Icons.search),
            search: true,
            suffixIcon: true,
          ),
        ),
        const SizedBox(width: 5),
        SquareIconButton(
          icon: Icons.filter_list_rounded,
          onTap: () {
            filterBottomSheet(context);
          },
        )
      ],
    );
  }
}

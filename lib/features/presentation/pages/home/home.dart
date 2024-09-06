import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/home/widgets/carousal.dart';
import 'package:fork_and_fusion/features/presentation/pages/home/widgets/category.dart';
import 'package:fork_and_fusion/features/presentation/pages/home/widgets/custome_item_card.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter_bottom_sheet.dart';
import 'package:fork_and_fusion/features/presentation/widgets/prodct_listtile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';

class Home extends StatelessWidget {
  Home({super.key});
  RangeValues rangeValues = const RangeValues(0, 1200);
  @override
  Widget build(BuildContext context) {
    var gap = const SizedBox(
      height: 10,
    );
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Carousal(height: Constants.dHeight),
          gap,
          CustomeItemCard(
            height: Constants.dHeight,
            title: '    Special offers',
          ),
          gap,
          CustomeItemCard(
            height: Constants.dHeight,
            title: '   Seasonal foods',
            offer: false,
          ),
          gap,
          CategoryHome(width: Constants.dWidth),
          _buildTextfield(context),
          _buildListView(Constants.dHeight)
        ],
      ),
    );
  }

  Column _buildListView(double height) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) => ProductListTile(
            height: height,
          ),
        ),
      ],
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
        const SizedBox(
          width: 5,
        ),
        SquareIconButton(
          icon: Icons.filter_list_rounded,
          onTap: () {
            filterBottomSheet(context);
          },
        )
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      title: SquareIconButton(
        icon: Icons.qr_code_scanner_rounded,
        onTap: () async {
          var scannedData = await Navigator.of(context).pushNamed('/qrscanner');
        },
      ),
      actions: [
        SquareIconButton(
          icon: Icons.search,
          onTap: () {
            Navigator.of(context).pushNamed('/search');
          },
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}

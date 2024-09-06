import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter_bottom_sheet.dart';
import 'package:fork_and_fusion/features/presentation/widgets/prodct_listtile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            _buildTextFielAndFilter(searchController, context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: 10,
                itemBuilder: (context, index) => ProductListTile(
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildTextFielAndFilter(
      TextEditingController searchController, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Row(
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
                  filterBottomSheet(context, true);
                },
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Text('20 Results found'),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/debouncer.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/product/product_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/custom_eleavated_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/filter_bottom_sheet.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/other/filter_variables.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/prodct_listtile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';

class Search extends StatelessWidget {
  Search({super.key});
  bool visible = true;
  FilterVariables varibles = FilterVariables();
  final ProductBloc bloc = ProductBloc();
  Debouncer debeoucer = Debouncer(milliseconds: 300);
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    varibles.cubit.loadAllCategories();
    bloc.add(FeatchAllProducts());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search')),
        body: Column(
          children: [
            _buildSearchFieldAndFilter(context),
            _buildListView(),
          ],
        ),
      ),
    );
  }

  BlocBuilder _buildListView() {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is ProductCompletedState) {
          return _listView(state.data);
        } else if (state is ProductErrorState) {
          return _centerText(state.message);
        } else if (state is ProductNoDataOnFilterState) {
          return _refresh();
        }
        return Constants.none;
      },
    );
  }

  Expanded _refresh() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "We couldn't find any matches. Try different filters or explore other options",
              textAlign: TextAlign.center,
            ),
            CustomEleavatedButton(
              text: 'Refresh',
              onPressed: () => bloc.add(FeatchAllProducts()),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _listView(List<ProductEntity> data) {
    if (data.isEmpty) {
      return _centerText(
          "No matching results found. Please try a different search term.");
    }
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          bloc.add(FeatchAllProducts());
          searchController.clear();
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: data.length,
          itemBuilder: (context, index) =>
              ProductListTile(product: data[index], fromSearch: true),
        ),
      ),
    );
  }

  Expanded _centerText(String message) {
    return Expanded(
        child: Center(child: Text(message, textAlign: TextAlign.center)));
  }

  Container _buildSearchFieldAndFilter(BuildContext context) {
    return Container(
      padding: Constants.padding10,
      child: StatefulBuilder(
        builder: (context, setState) => Row(
          children: [
            Expanded(
              child: CustomTextField(
                onChanged: (querry) {
                  setState(() => visible = querry.isEmpty);
                  debeoucer.run(
                    () {
                      if (querry.isEmpty) {
                        bloc.add(FeatchAllProducts());
                      } else {
                        bloc.add(SearchProductEvent(querry.toLowerCase()));
                      }
                    },
                  );
                },
                action: () {
                  searchController.clear();
                  bloc.add(FeatchAllProducts());
                },
                width: 1,
                hintText: 'Search...',
                controller: searchController,
                prefixIcon: const Icon(Icons.search),
                search: true,
              ),
            ),
            Visibility(
              visible: visible,
              child: const SizedBox(width: 5),
            ),
            Visibility(
              visible: visible,
              child: SquareIconButton(
                  icon: Icons.filter_list_rounded,
                  onTap: () => filterBottomSheet(context, varibles, bloc)),
            )
          ],
        ),
      ),
    );
  }
}

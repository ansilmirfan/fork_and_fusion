import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/product/product_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/category_listview_bottomSheet.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/other/filter_variables.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/other/functions.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';

class FilterWidget extends StatelessWidget {
  FilterVariables varible;
  ProductBloc bloc;

  FilterWidget({super.key, required this.varible, required this.bloc});

  var gap = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.padding10,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 208, 208, 208),
          borderRadius: Constants.radius,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCategory(context),
              gap,
              _buildSlider(setState),
              gap,
              _buildSort(setState),
              gap,
              _applyButton(context)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _applyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomTextButton(
        text: 'Apply',
        onPressed: () {
          var selectedCategory =
              varible.cubit.category.where((e) => e.selected).toList();
          bloc.add(ProductFilterEvent(
              nameState: varible.nameState,
              priceState: varible.priceState,
              rangeValues: varible.rangeValues,
              selectedCategory: selectedCategory));
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Material _buildCategory(BuildContext context) {
    return Material(
      borderRadius: Constants.radius,
      elevation: 10,
      child: InkWell(
        onTap: () => showCategoryListViewBottomSheet(varible.cubit, context),
        child: Container(
          padding: Constants.padding10,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Category'), Text('view all')],
          ),
        ),
      ),
    );
  }

  Material _buildSort(StateSetter setState) {
    return Material(
      borderRadius: Constants.radius,
      elevation: 10,
      child: Container(
        padding: Constants.padding10,
        child: Column(
          children: [
            const Text('Sort'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _sortButton(setState, 'Price', false),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _sortButton(setState, 'Name', true),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Material _sortButton(StateSetter setState, String name, bool isNameSort) {
    return Material(
      elevation: 10,
      borderRadius: Constants.radius,
      child: InkWell(
        borderRadius: Constants.radius,
        onTap: () {
          setState(() {
            if (isNameSort) {
              varible.nameState = FilterUtils.getNextState(varible.nameState);
              varible.priceState = FilterStates.initial;
            } else {
              varible.priceState = FilterUtils.getNextState(varible.priceState);
              varible.nameState = FilterStates.initial;
            }
          });
        },
        child: Padding(
          padding: Constants.padding10,
          child: Row(
            children: [
              Text(name),
              const Spacer(),
              isNameSort
                  ? FilterUtils.getIcon(varible.nameState)
                  : FilterUtils.getIcon(varible.priceState),
            ],
          ),
        ),
      ),
    );
  }

  Material _buildSlider(StateSetter setState) {
    return Material(
      borderRadius: Constants.radius,
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('Price'),
            const SizedBox(
              height: 10,
            ),
            //--------range slider-------------
            RangeSlider(
              min: 0,
              max: 10000,
              divisions: 500,
              labels: RangeLabels('${varible.rangeValues.start.toInt()}',
                  '${varible.rangeValues.end.toInt()}'),
              values: varible.rangeValues,
              onChanged: (value) {
                setState(
                  () => varible.rangeValues = value,
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    borderRadius: Constants.radius,
                    elevation: 10,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        varible.rangeValues.start.toInt().toString(),
                      ),
                    ),
                  ),
                ),
                const Text('   -   '),
                Expanded(
                  child: Material(
                    borderRadius: Constants.radius,
                    elevation: 10,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Text(varible.rangeValues.end.toInt().toString()),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

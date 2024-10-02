import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/category_listview_bottomSheet.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/other/filter_variables.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class FilterWidget extends StatelessWidget {
  FilterVariables varible;

  FilterWidget({super.key, required this.varible});

  var gap = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
              _buildSort(),
              gap,
              SizedBox(
                width: double.infinity,
                child: CustomTextButton(
                  text: 'Apply',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
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

  Material _buildSort() {
    return Material(
      borderRadius: Constants.radius,
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('Sort'),
            gap,
            Row(
              children: [
                Expanded(
                  child: Material(
                    borderRadius: Constants.radius,
                    elevation: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Price'), Icon(Icons.arrow_upward)],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Material(
                    borderRadius: Constants.radius,
                    elevation: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Name'), Icon(Icons.arrow_upward)],
                        ),
                      ),
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

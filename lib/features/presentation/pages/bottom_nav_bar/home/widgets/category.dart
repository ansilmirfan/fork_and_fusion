import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/category_bottom_sheet.dart';

class CategoryHome extends StatelessWidget {
  double width;

  CategoryHome({super.key, required this.width});
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Category'),
            TextButton(
              onPressed: () {
                categoryBottomSheet(context);
              },
              child: const Text('more..'),
            )
          ],
        ),
        SizedBox(
          height: width * .20,
          child: CarouselView(
            itemExtent: width * .2,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: width * .07,
                    child: const Text('All'),
                  ),
                ],
              ),
              ...List.generate(
                15,
                (index) => Material(
                  shape: const CircleBorder(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          radius: width * .07,
                          backgroundImage: NetworkImage(Constants.image),
                        ),
                      ),
                      SizedBox(
                        width: width * .14,
                        child: Text(
                          'Category',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  
}

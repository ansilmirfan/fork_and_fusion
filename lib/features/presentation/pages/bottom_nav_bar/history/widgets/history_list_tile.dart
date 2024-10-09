import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/rich_label_text.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';

class HistoryListTile extends StatelessWidget {
  int index;
  bool today;
  HistoryListTile({super.key, required this.index, this.today = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 10,
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: Constants.radius,
        child: InkWell(
          borderRadius: Constants.radius,
          onTap: () {
            Navigator.of(context).pushNamed('/orderview', arguments: today);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Order id:10121000120002'),
                RichLabelText(text1: 'Status:', text2: 'Cooking'),
                RichLabelText(text1: 'Order Time:', text2: '10:05 AM'),
                Visibility(
                  visible: today,
                  child: CustomTextButton(
                    text: 'Cancel',
                    onPressed: index.isOdd ? () {} : null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

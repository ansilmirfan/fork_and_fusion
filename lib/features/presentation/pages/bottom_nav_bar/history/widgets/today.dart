import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/history_list_tile.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    var gap = const SizedBox(
      height: 10,
    );
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gap,
          Text(
            'Subtotal ₹480',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => HistoryListTile(
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

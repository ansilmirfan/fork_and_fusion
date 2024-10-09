import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/usecase/converters.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/date_alert_dialog.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/history_list_tile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';

class All extends StatelessWidget {
  const All({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal ₹480',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SquareIconButton(
                icon: Icons.calendar_month,
                onTap: () async {
                  DateTime? picked = await dateAlertDialog(context);
                },
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) =>
                  index == 0 ? Constants.none : _buildDate(context),
              itemBuilder: (context, index) => Column(
                children: List.generate(
                  index % 10,
                  (index) => SizedBox(
                    width: double.infinity,
                    child: HistoryListTile(
                      index: index,
                      today: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center _buildDate(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: Constants.radius,
        ),
        child: Text(
          Converters.dateToString(
            DateTime(2024),
          ),
        ),
      ),
    );
  }
}

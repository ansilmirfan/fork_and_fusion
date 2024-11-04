import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/history_list_tile.dart';

class PickedDataPage extends StatelessWidget {
  final List<OrderEntity> orders;
  const PickedDataPage({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Utils.formatDate(orders.first.date)),),
      body: ListView.builder(
        padding: Constants.padding10,
        itemCount: orders.length,
        itemBuilder: (context, index) => HistoryListTile(order: orders[index]),
      ),
    );
  }
}

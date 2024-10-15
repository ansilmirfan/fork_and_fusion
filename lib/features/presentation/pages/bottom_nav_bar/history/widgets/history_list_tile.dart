import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/rich_label_text.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';
import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';

class HistoryListTile extends StatelessWidget {
  OrderEntity order;
  HistoryListTile({super.key, required this.order});
  final currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Duration difference = currentTime.difference(order.date);
    bool canCancel = difference.inSeconds <= 300;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedContainer(
        child: InkWell(
          borderRadius: Constants.radius,
          onTap: () =>
              Navigator.of(context).pushNamed('/orderview', arguments: order),
          child: Container(
            padding: Constants.padding10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order id:${order.id}'),
                _orderStatus(),
                _time(),
                _cancelButton(canCancel)
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichLabelText _orderStatus() {
    return RichLabelText(
      text1: 'Status:',
      text2: order.status,
    );
  }

  RichLabelText _time() {
    return RichLabelText(
        text1: 'Order Time:', text2: Utils.formatTime(order.date));
  }

  Visibility _cancelButton(bool canCancel) {
    return Visibility(
      visible: canCancel,
      child: CustomTextButton(
        text: 'Cancel',
        onPressed: () {},
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/date_alert_dialog.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/history_list_tile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/empty_message.dart';
import 'package:fork_and_fusion/features/presentation/widgets/loading.dart';

class All extends StatelessWidget {
  const All({super.key});
  final gap = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>();
    return RefreshIndicator(
      onRefresh: () async => context.read<OrderBloc>().add(OrderGetAllEvent()),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoadingState) {
            return Loading();
          }
          if (state is OrderCompletedState) {
            return _buildBody(context, state.orders);
          }
          return EmptyMessage(message: 'Network Error');
        },
      ),
    );
  }

  Padding _buildBody(BuildContext context, List<OrderEntity> orders) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_subtotal(context,orders), _datePicker(context)],
          ),
          _listView(orders),
        ],
      ),
    );
  }

  Widget _listView(List<OrderEntity> orders) {
    orders = orders.reversed.toList();
    var ordersMap = convertToMap(orders);
    var keys = ordersMap.keys.toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        String dateKey = keys[index];
        var ordersForDate = ordersMap[dateKey] ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDate(context, dateKey),
            Column(
              children: List.generate(
                ordersForDate.length,
                (i) => SizedBox(
                  width: double.infinity,
                  child: HistoryListTile(order: ordersForDate[i],),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Center _buildDate(BuildContext context, String dateKey) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: Constants.radius,
        ),
        child: Text(dateKey),
      ),
    );
  }

  SquareIconButton _datePicker(BuildContext context) {
    return SquareIconButton(
      icon: Icons.calendar_month,
      onTap: () async {
        DateTime? picked = await dateAlertDialog(context);
      },
    );
  }

  Text _subtotal(BuildContext context, List<OrderEntity> orders) {
    var total = orders.map((e) => e.amount).reduce((a, b) => a + b);
    return Text(
      'Subtotal ₹$total',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Map<String, List<OrderEntity>> convertToMap(List<OrderEntity> orders) {
    Map<String, List<OrderEntity>> map = {};
    for (var element in orders) {
      var date = Utils.formatDate(element.date);
      map[date] ??= [];
      map[date]?.add(element);
    }
    return map;
  }
}

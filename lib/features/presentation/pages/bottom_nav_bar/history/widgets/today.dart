import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/history_list_tile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/empty_message.dart';
import 'package:fork_and_fusion/features/presentation/widgets/loading.dart';

class Today extends StatelessWidget {
  const Today({super.key});
    final gap = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async {
        context.read<OrderBloc>().add(OrderGetAllEvent());
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadingState) {
              return Loading();
            }
            if (state is OrderCompletedState) {
              return _buildBody(state.orders, context);
            }
            return EmptyMessage(message: 'Network Error');
          },
        ),
      ),
    );
  }

  StatelessWidget _buildBody(List<OrderEntity>order, BuildContext context) {
      List<OrderEntity> orders = List.from(todaysOrders(order));
    if (orders.isEmpty) {
      return EmptyMessage(
          message: "No orders today. Ready to place one?");
    }
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gap,
          _subtotal(context, orders),
          gap,
          _listView(orders),
        ],
      ),
    );
  }

  Widget _listView(List<OrderEntity> orders) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) => HistoryListTile(
        order: orders[index],
      ),
    );
  }

  Text _subtotal(BuildContext context, List<OrderEntity> orders) {
    var total = orders.map((e) => e.amount).reduce((a, b) => a + b);
    return Text(
      'Subtotal ₹$total',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  List<OrderEntity> todaysOrders(List<OrderEntity> orders) {
    final today = DateTime.now();
    orders = orders
        .where((e) =>
            e.date.day == today.day &&
            e.date.month == today.month &&
            e.date.year == today.year)
        .toList();
    return orders;
  }
}

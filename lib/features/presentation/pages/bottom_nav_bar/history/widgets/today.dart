import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/widgets/history_list_tile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/empty_message.dart';
import 'package:fork_and_fusion/features/presentation/widgets/loading.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    var gap = const SizedBox(height: 10);
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
              if (state.orders.isEmpty) {
                return EmptyMessage(
                    message: "No orders today. Ready to place one?");
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gap,
                  _subtotal(context, state.orders),
                  gap,
                  _listView(state.orders),
                ],
              );
            }
            return EmptyMessage(message: 'Network Error');
          },
        ),
      ),
    );
  }

  Widget _listView(List<OrderEntity> orders) {
    final today = DateTime.now();
    orders = orders
        .where((e) =>
            e.date.day == today.day &&
            e.date.month == today.month &&
            e.date.year == today.year)
        .toList();
    orders = orders.reversed.toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
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
}

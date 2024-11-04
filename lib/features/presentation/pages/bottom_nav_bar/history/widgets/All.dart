// ignore_for_file: use_build_context_synchronously
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
import 'package:fork_and_fusion/features/presentation/widgets/overlay_loading.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';

class All extends StatelessWidget {
  final ScrollController controller;
  All({super.key, required this.controller});
  final gap = const SizedBox(height: 10);
  Map<String, List<OrderEntity>> ordersMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>();
    return RefreshIndicator(
      onRefresh: () async => context.read<OrderBloc>().add(OrderGetAllEvent()),
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderCancelLoadingEvent) {
            showLoadingOverlay(context);
          } else {
            hideLoadingOverlay();
          }
        },
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

  _buildBody(BuildContext context, List<OrderEntity> orders) {
    if (orders.isEmpty) {
      return EmptyMessage(message: 'No orders yet,Ready to order?');
    }
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_subtotal(context, orders), _datePicker(context)],
            ),
            _listView(orders),
          ],
        ),
      ),
    );
  }

  Widget _listView(List<OrderEntity> orders) {
    ordersMap = convertToMap(orders);
    var keys = ordersMap.keys.toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      controller: controller,
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
                  child: HistoryListTile(
                    order: ordersForDate[i],
                  ),
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
      key: Key(dateKey),
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
        if (picked != null) {
          final formattedDate = Utils.formatDate(picked);

          _showPickedData(formattedDate, context);
        }
      },
    );
  }

  _showPickedData(String dateKey, BuildContext context) {
    if (ordersMap.containsKey(dateKey)) {
      final orders = ordersMap[dateKey] ?? [];
      if (orders.isNotEmpty) {
        Navigator.of(context).pushNamed('/picked datapage', arguments: orders);
      }
    } else {
      showCustomSnackbar(
        context: context,
        message: "No Data found for the selected date",
        isSuccess: false,
      );
    }
  }

  Text _subtotal(BuildContext context, List<OrderEntity> orders) {
    var total = orders.map((e) => e.amount).reduce((a, b) => a + b);
    return Text(
      'Subtotal ₹$total',
      style: Theme.of(context).textTheme.headlineSmall,
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

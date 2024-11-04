import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/product_listtile.dart';

class OrderView extends StatelessWidget {
  final OrderEntity order;
  const OrderView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(order.paymentId)),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderRatingCompletedState) {
            for (var element in order.products) {
              if (element.product.id == state.productId) {
                element.rated = true;
              }
            }
          }
          return _listView(context);
        },
      ),
    );
  }

  ListView _listView(BuildContext context) {
    return ListView(
      padding: Constants.padding10,
      children: [
        _subtotalText(context),
        _buildOrderStatus(context),
        ..._buildProductList()
      ],
    );
  }

  List<Widget> _buildProductList() {
    return List.generate(
      order.products.length,
      (index) => ProductListTile(
        type: ListType.historyView,
        cart: order.products[index],
        order: order,
      ),
    );
  }

  Row _buildOrderStatus(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          order.status,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        Text('${Utils.formatDate(order.date)} ${Utils.formatTime(order.date)}')
      ],
    );
  }

  Text _subtotalText(BuildContext context) {
    return Text('Subtotal ₹ ${order.amount}',
        style: Theme.of(context).textTheme.headlineMedium);
  }
}

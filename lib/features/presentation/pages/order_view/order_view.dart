import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/prodct_listtile.dart';

class OrderView extends StatelessWidget {
  bool today;
  OrderView({super.key, this.today = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('12424121221123211')),
      body: ListView(
        padding: Constants.padding10,
        children: [
          _subtotalText(context),
          _buildOrderStatus(context),
          ..._buildProductList()
        ],
      ),
    );
  }

  List<Widget> _buildProductList() {
    return List.generate(
          5,
          (index) => ProductListTile(
            type: today ? ListType.historyViewToday : ListType.historyView,
            parcel: index.isOdd,
          ),
        );
  }

  Row _buildOrderStatus(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cooking',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            today ? const Text('10:05 AM') : const Text('12/6/2024')
          ],
        );
  }

  Text _subtotalText(BuildContext context) {
    return Text('Subtotal 2500',
        style: Theme.of(context).textTheme.headlineMedium);
  }
}

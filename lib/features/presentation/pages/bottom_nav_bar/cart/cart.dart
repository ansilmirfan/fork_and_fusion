
import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_quantity/cart_quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_appbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/prodct_listtile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    List<CartQuantityBloc> bloc =
        List.generate(15, (index) => CartQuantityBloc());

    var gap = const SizedBox(
      height: 10,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: Constants.padding10,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Subtotal 180',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  gap,
                  CustomeTextButton(
                    text: 'Proceeds to buy(1 item)',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 15,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ProductListTile(
                bloc: bloc[index],
                type: ListType.cartView,
              ),
            ),
          )
        ],
      ),
    );
  }
}

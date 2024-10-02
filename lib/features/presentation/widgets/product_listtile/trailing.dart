import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_quantity/cart_quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/order_view/widgets/rating_dialog.dart';
import 'package:fork_and_fusion/features/presentation/pages/search/bouncing_heart.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';

class Trailing {
 static Expanded historyViewTrailing(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            await ratingDialog(context);
          },
          icon: const Icon(
            Icons.star_border,
            size: 35,
          ),
        ),
        const Text('Rate')
      ],
    ));
  }

 static Expanded cartViewTrailing(CartQuantityBloc bloc) {
    return Expanded(
        child: BlocBuilder<CartQuantityBloc, CartQuantityState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is CartQuantityInitialState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SquareIconButton(
                icon: Icons.add,
                white: false,
                onTap: () => bloc.add(CartQuantityAddEvent()),
              ),
              Material(
                borderRadius: Constants.radius,
                elevation: 10,
                color: Theme.of(context).colorScheme.tertiary,
                child: Container(
                  width: 40,
                  padding: Constants.padding10,
                  child: Text(
                    state.quantity.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SquareIconButton(
                icon: Icons.remove,
                white: false,
                onTap: () => bloc.add(CartQuantityReduceEvent()),
              ),
            ],
          );
        }
        return Constants.none;
      },
    ));
  }

static  Expanded productViewTrailing() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
           BouncingHeartButton(),
            Expanded(
              child: SquareIconButton(
                icon: Icons.add,
                height: 15,
                white: false,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/order_view/widgets/rating_dialog.dart';
import 'package:fork_and_fusion/features/presentation/widgets/add_to_cart_bottomsheet.dart';

import 'package:fork_and_fusion/features/presentation/widgets/bouncing_heart.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';

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

  static Expanded cartViewTrailing(BuildContext context, CartEntity cart) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        _squareButton(
          true,
          () => context
              .read<CartManagementBloc>()
              .add(CartManagementUpdateQuantityEvent(true, cart)),
        ),
        const SizedBox(height: 10),
        Material(
          borderRadius: Constants.radius,
          elevation: 10,
          color: Theme.of(context).colorScheme.tertiary,
          child: Container(
            width: 40,
            padding: Constants.padding10,
            child: Text(
              cart.quantity.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _squareButton(
          false,
          () => context
              .read<CartManagementBloc>()
              .add(CartManagementUpdateQuantityEvent(false, cart)),
        ),
      ],
    ));
  }

  static Expanded productViewTrailing(
      BuildContext context, ProductEntity product,FavouriteBloc bloc,bool fromFavourite) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            BouncingHeartButton(id: product.id,bloc: bloc,fromFavourite: fromFavourite,),
            Expanded(
              child: _squareButton(
                  true, () => showAddToCartBottomSheet(context, product), 15),
            ),
          ],
        ),
      ),
    );
  }

  static SquareIconButton _squareButton(bool addButton, void Function()? onTap,
      [double height = 25]) {
    return SquareIconButton(
      icon: addButton ? Icons.add : Icons.remove,
      white: false,
      onTap: onTap,
      height: height,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/order_view/widgets/rating_dialog.dart';
import 'package:fork_and_fusion/features/presentation/widgets/add_to_cart_bottomsheet.dart';

import 'package:fork_and_fusion/features/presentation/widgets/buttons/bouncing_heart.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';

class Trailing {
  static historyViewTrailing(
      BuildContext context, String status, OrderEntity order, CartEntity cart) {
    return Visibility(
      visible: status == 'Served' && !cart.rated,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              await ratingDialog(context, cart, order);
            },
            icon: const Icon(
              Icons.star_border,
              size: 35,
            ),
          ),
          const Text('Rate')
        ],
      ),
    );
  }

  static cartViewTrailing(BuildContext context, CartEntity cart) {
    return FittedBox(
      fit: BoxFit.scaleDown,
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
          Gap(gap: 10),
          ElevatedContainer(
            child: Container(
              constraints: BoxConstraints(maxHeight: 40),
              width: 40,
              padding: EdgeInsets.all(8),
              child: FittedBox(
                child: Text(
                  cart.quantity.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Gap(gap: 10),
          _squareButton(
            false,
            () => context
                .read<CartManagementBloc>()
                .add(CartManagementUpdateQuantityEvent(false, cart)),
          ),
        ],
      ),
    );
  }

  static productViewTrailing(BuildContext context, ProductEntity product,
      FavouriteBloc bloc, bool fromFavourite) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          BouncingHeartButton(
            id: product.id,
            bloc: bloc,
            fromFavourite: fromFavourite,
          ),
          Expanded(
            child: _squareButton(
                true, () => showAddToCartBottomSheet(context, product), 15),
          ),
        ],
      ),
    );
  }

  static SquareIconButton _squareButton(bool addButton, void Function()? onTap,
      [double? height]) {
    return SquareIconButton(
      icon: addButton ? Icons.add : Icons.remove,
      white: false,
      onTap: onTap,
      height: height,
    );
  }
}

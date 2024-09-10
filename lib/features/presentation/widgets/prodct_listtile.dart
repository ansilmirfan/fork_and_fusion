import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_quantity/cart_quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/order_view/widgets/rating_dialog.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class ProductListTile extends StatelessWidget {
  ListType type;
  bool parcel;
  CartQuantityBloc? bloc;
  ProductListTile(
      {super.key,
      this.bloc,
      this.type = ListType.productView,
      this.parcel = false});

  @override
  Widget build(BuildContext context) {
    var height = Constants.dHeight;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        borderRadius: Constants.radius,
        elevation: 10,
        color: Theme.of(context).colorScheme.tertiary,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/productview');
          },
          child: Container(
            height: type == ListType.historyViewToday
                ? height * 0.25
                : height * 0.18,
            padding: const EdgeInsets.all(5),
            child: type == ListType.historyViewToday
                ? Column(
                    children: [
                      Row(
                        children: [
                          _buildImage(height),
                          _buildProductDetails(context),
                          _buildTrailing(type, context),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomeTextButton(
                        text: 'Cancel',
                        onPressed: () {},
                      )
                    ],
                  )
                : Row(
                    children: [
                      _buildImage(height),
                      _buildProductDetails(context),
                      _buildTrailing(type, context),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Expanded _buildTrailing(ListType type, BuildContext context) {
    switch (type) {
      case ListType.productView:
        return Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
                Expanded(
                  child: SquareIconButton(
                    icon: Icons.add,
                    height: 15,
                    white: false,
                    onTap: () {},
                  ),
                )
              ],
            ),
          ),
        );
      case ListType.cartView:
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
                    onTap: () => bloc?.add(CartQuantityAddEvent()),
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
                    onTap: () => bloc?.add(CartQuantityReduceEvent()),
                  ),
                ],
              );
            }
            return Constants.none;
          },
        ));
      case ListType.historyView:
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

      default:
        return const Expanded(child: SizedBox());
    }
  }

  Expanded _buildProductDetails(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dish Name'),
            Visibility(
              visible: type == ListType.historyView ||
                  type == ListType.historyViewToday,
              child: const Text('X 2'),
            ),
            Text(
              '₹120',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
            Visibility(
              visible: !(type == ListType.historyView ||
                  type == ListType.historyViewToday),
              child: const Wrap(
                children: [Icon(Icons.star_border_purple500), Text('4.5')],
              ),
            ),
            Visibility(
              visible: parcel,
              child: const Text('Parcel'),
            ),
            Visibility(
              visible: type == ListType.cartView,
              child: BlocBuilder<CartQuantityBloc, CartQuantityState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is CartQuantityInitialState) {
                    return ChoiceChip(
                      label: const Text('Parcel'),
                      selected: state.parcel,
                      onSelected: (value) => bloc?.add(CartParcelEvent()),
                    );
                  }
                  return Constants.none;
                },
              ),
            ),
            Visibility(
              visible: type == ListType.historyView ||
                  type == ListType.historyViewToday,
              child: Text(
                'Cooking',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildImage(var height) {
    return Stack(
      children: [
        SizedBox(
          height: height * .18 - 5,
          width: height * .18 - 5,
          child: ClipRRect(
            borderRadius: Constants.radius,
            child: const CacheImage(),
          ),
        ),
        Visibility(
          visible: type == ListType.cartView,
          child: BlocBuilder<CartQuantityBloc, CartQuantityState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is CartQuantityInitialState) {
                return Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: state.isSelected,
                    onChanged: (value) => bloc?.add(CartSelectedEvent()),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 2,
                    ),
                  ),
                );
              }
              return Constants.none;
            },
          ),
        )
      ],
    );
  }
}

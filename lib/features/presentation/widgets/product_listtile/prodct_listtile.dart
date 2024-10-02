import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_quantity/cart_quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/trailing.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class ProductListTile extends StatelessWidget {
  ListType type;
  bool parcel;
  ProductEntity? product;
  CartQuantityBloc? bloc;
  ProductListTile(
      {super.key,
      this.product,
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
            Navigator.of(context).pushNamed('/productview', arguments: product);
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
                      const SizedBox(height: 5),
                      CustomTextButton(
                        text: 'Cancel',
                        onPressed: () {},
                      )
                    ],
                  )
                : Row(
                    children: [
                      _buildImage(height, product?.image.first ?? ''),
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
        return Trailing.productViewTrailing();
      case ListType.cartView:
        return Trailing.cartViewTrailing(bloc!);
      case ListType.historyView:
        return Trailing.historyViewTrailing(context);

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
            //-------product name------------
            Text(Utils.capitalizeEachWord(product?.name ?? '')),
            //-----------quantity--------------------
            //--------visible only if it is in the history page------------
            Visibility(
              visible: type == ListType.historyView ||
                  type == ListType.historyViewToday,
              child: const Text('X 2'),
            ),
            //--------------price---------------
            Text(
              '₹${Utils.extractPrice(product!)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
            //---------------rating-----------------
            //-------------Visible only in cart and product view Not in the order history-------
            Visibility(
              visible: !(type == ListType.historyView ||
                  type == ListType.historyViewToday),
              child: Wrap(
                children: [
                  const Icon(Icons.star_border_purple500),
                  Text('${Utils.calculateRating(product?.rating ?? [])}')
                ],
              ),
            ),
            //---------------parcel only in the cart list-------------
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

  Stack _buildImage(var height, [String url = '']) {
    return Stack(
      children: [
        //-------image--------------
        Hero(
          tag: '${product!.id}0',
          child: SizedBox(
            height: height * .18 - 5,
            width: height * .18 - 5,
            child: ClipRRect(
              borderRadius: Constants.radius,
              child: CacheImage(url: url),
            ),
          ),
        ),
        //-------------------check box for selecting only visible in the cart area--------
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

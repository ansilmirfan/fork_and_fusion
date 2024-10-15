import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/center_data.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/custom_dismissible.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/trailing.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';

class ProductListTile extends StatelessWidget {
  ListType type;
  bool parcel;
  FavouriteBloc? favouriteBloc;
  ProductEntity? product;
  CartEntity? cart;
  bool fromSearch;
  bool fromFavourite;

  ProductListTile(
      {super.key,
      this.product,
      this.type = ListType.productView,
      this.cart,
      this.favouriteBloc,
      this.fromSearch = false,
      this.fromFavourite = false,
      this.parcel = false});

  @override
  Widget build(BuildContext context) {
    context.read<CartManagementBloc>();
    var height = Constants.dHeight;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: type == ListType.cartView
          ? _buildDismissibleContainer(context, height)
          : _buildElevatedContainer(context, height),
    );
  }

  DismissibleProductTile _buildDismissibleContainer(
      BuildContext context, double height) {
    return DismissibleProductTile(
        id: cart!.id, child: _buildElevatedContainer(context, height));
  }

  ElevatedContainer _buildElevatedContainer(
      BuildContext context, double height) {
    return ElevatedContainer(
      padding: 0.0,
      child: InkWell(
        onTap: () => _navigate(context),
        child: Container(
          height:
              type == ListType.historyViewToday ? height * 0.25 : height * 0.18,
          padding: const EdgeInsets.all(5),
          child:
              // type == ListType.historyViewToday
              //     ? _historyViewToday(height, context)
              Row(
            children: [
              _buildImage(height, context),
              _buildProductDetails(type, context),
              _buildTrailing(type, context),
            ],
          ),
        ),
      ),
    );
  }

  Future<Object?> _navigate(BuildContext context) {
    return Navigator.of(context).pushNamed('/productview', arguments: {
      'product': type == ListType.cartView ? cart!.product : product,
      'from': type == ListType.cartView,
      'cart': cart
    });
  }

  Column _historyViewToday(double height, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildImage(height, context),
            _buildProductDetails(type, context),
            _buildTrailing(type, context),
          ],
        ),
        const SizedBox(height: 5),
        CustomTextButton(
          text: 'Cancel',
          onPressed: () {},
        )
      ],
    );
  }

  Expanded _buildTrailing(ListType type, BuildContext context) {
    switch (type) {
      case ListType.productView:
        return Trailing.productViewTrailing(
            context, product!, favouriteBloc!, fromFavourite);
      case ListType.cartView:
        return Trailing.cartViewTrailing(context, cart!);
      case ListType.historyView:
        return Trailing.historyViewTrailing(context);

      default:
        return const Expanded(child: SizedBox());
    }
  }

  Expanded _buildProductDetails(ListType type, BuildContext context) {
    switch (type) {
      case ListType.productView:
        return CenterData.productView(product!, context);

      case ListType.cartView:
        return CenterData.cartView(cart!, context);
      case ListType.historyView:
        return CenterData.historyView(context);

      default:
        return const Expanded(child: SizedBox());
    }
  }

  Stack _buildImage(var height, BuildContext context) {
    return Stack(
      children: [
        //-------image--------------
        SizedBox(
          height: height * .18 - 5,
          width: height * .18 - 5,
          child: ClipRRect(
              borderRadius: Constants.radius,
              child: CacheImage(
                url: getUrl()!,
              )),
        ),
        //-------------------check box for selecting only visible in the cart area--------
        Visibility(
          visible: type == ListType.cartView,
          child: Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: cart?.isSelected ?? false,
              onChanged: (value) {
                context
                    .read<CartManagementBloc>()
                    .add(CartManagementSelectedEvent(cart!));
              },
              side: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }

  String? getUrl() {
    switch (type) {
      case ListType.productView:
        return product?.image.first;
      case ListType.cartView:
        return cart?.product.image.first;

      default:
        return null;
    }
  }
}

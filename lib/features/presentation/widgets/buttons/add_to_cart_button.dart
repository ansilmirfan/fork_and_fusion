import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';

class AddToCartButton extends StatelessWidget {
  final CartManagementBloc cartBloc;
  final QuantityBloc quantityBloc;
  final ProductEntity product;
  final CartEntity? cartEntity;
  final String Function() getSelectedVariant;
  final String Function() cookingRequest;
  final void Function() resetField;
  final bool fromCart;
  final bool fromSearch;
  const AddToCartButton(
      {super.key,
      required this.cartBloc,
      this.cartEntity,
      required this.quantityBloc,
      required this.product,
      required this.getSelectedVariant,
      required this.cookingRequest,
      required this.fromCart,
      this.fromSearch = false,
      required this.resetField});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.padding10,
      child: BlocConsumer<CartManagementBloc, CartManagementState>(
        bloc: cartBloc,
        buildWhen: (previous, current) {
          if (fromCart) {
            return false;
          }
          return true;
        },
        listener: (context, state) {
          if (state is CartManagementEditedState) {
            Navigator.of(context).pop();
            context.read<CartManagementBloc>().add(CartManagemntGetAllEvent());
          }
          if (state is CartManagementAddedToCartState) {
            cartBloc.add(CartManagementCheckForDuplicate(
                parcel: quantityBloc.parcelStatus,
                productId: product.id,
                selectedVarinat: getSelectedVariant()));
            resetField();
            context.read<CartManagementBloc>().add(CartManagemntGetAllEvent());

            showCustomSnackbar(
                context: context, message: '${product.name} added to cart');
          }
          if (state is CartManagementErrorState) {
            showCustomSnackbar(
                context: context, message: state.message, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (state is CartManagementLoadingState) {
            return CustomTextButton(progress: true);
          }
          if (state is CartManagementGoToCartState) {
            return CustomTextButton(
              onPressed: () {
                if (fromSearch) {
                  Navigator.of(context).pop();
                 

                  Navigator.of(context).pushReplacementNamed('/bottomnav');
                  context.read<BottomNavCubit>().onPageChanage(1);
                } else {
                  Navigator.of(context).pop();
                  context.read<BottomNavCubit>().onPageChanage(1);
                }
              },
              text: 'Go to cart',
              icon: const Icon(Icons.shopping_cart),
            );
          }
          return CustomTextButton(
            text: fromCart ? 'Save' : 'Add to Cart',
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              CartEntity cart = CartEntity(
                  id: fromCart ? cartEntity?.id ?? '' : '',
                  product: product,
                  quantity: quantityBloc.quantity,
                  cookingRequest: cookingRequest(),
                  parcel: quantityBloc.parcelStatus,
                  isSelected:
                      fromCart ? cartEntity?.isSelected ?? false : false,
                  selectedType: getSelectedVariant());
              fromCart
                  ? cartBloc.add(CartManagementEditEvent(cart))
                  : cartBloc.add(CartManagementAddToCartEvent(cart));
            },
          );
        },
      ),
    );
  }
}

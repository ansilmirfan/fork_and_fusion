import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/selected_variant/selected_variant_cubit.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/cooking_request_field.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/image_carousal.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/ingrediants.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/parcel_choice_chip.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/quantity.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/rating.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/variant_selection_widget.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/add_to_cart_button.dart';


class ProductView extends StatelessWidget {
  ProductEntity product;
  bool fromCart;
  CartEntity? cart;
  ProductView(
      {super.key, required this.product, this.fromCart = false, this.cart});
  List<bool> selectedVariant = [];
  String selected = '';
  TextEditingController controller = TextEditingController();
  PageController pageController = PageController();
  late final CartManagementBloc cartBloc = CartManagementBloc();
  QuantityBloc quantityBloc = QuantityBloc();
  var gap = const SizedBox(height: 10);
  late SelectedVariantCubit variantCubit;

  @override
  Widget build(BuildContext context) {
    variantCubit = context.read<SelectedVariantCubit>();
    intialise(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ImageCarousal(images: product.image),
                  _buildbody(context),
                ],
              ),
            ),
            _addToCartButton(),
          ],
        ),
      ),
    );
  }

  void intialise(BuildContext context) {
    selectedVariant =
        List.generate(product.variants.length, (index) => index == 0);
    if (fromCart) {
      controller.text = cart?.cookingRequest ?? '';
      var varinats = product.variants.entries.toList();
      varinats.sort((a, b) => a.value.compareTo(b.value));
      selectedVariant = List.generate(
        varinats.length,
        (index) => varinats[index].key == cart?.selectedType,
      );
      context
          .read<SelectedVariantCubit>()
          .onSelectionChanged(cart?.selectedType ?? '');

      quantityBloc.add(
          QuantityInitialEvent(cart?.quantity ?? 1, cart?.parcel ?? false));
    }
    context.read<SelectedVariantCubit>();
    cartBloc.add(CartManagementCheckForDuplicate(
        parcel: false,
        productId: product.id,
        selectedVarinat: getSelectedVariant()));
  }

  AddToCartButton _addToCartButton() {
    return AddToCartButton(
      cartBloc: cartBloc,
      quantityBloc: quantityBloc,
      product: product,
      fromCart: fromCart,
      cartEntity: cart,
      getSelectedVariant: getSelectedVariant,
      cookingRequest: getCookingRequest,
      resetField: resetFields,
    );
  }



  Widget _buildbody(BuildContext context) {
    return Padding(
      padding: Constants.padding10,
      child: Column(
        children: [
          _buildDishNameAndPrice(context),
          gap,
          Ingrediants(
            gap: gap,
            ingrediants: product.ingredients,
          ),
          gap,
          //----------rating--------------
          Rating(rating: Utils.calculateRating(product.rating)),
          gap,
          CookingRequestField(controller: controller),
          gap,
          VariantSelectionWidget(
            product: product,
            selectedVariant: selectedVariant,
            parcel: quantityBloc.parcelStatus,
            cartBloc: cartBloc,
          ),
          gap,
          _buildQuantityAndParcelSection(),
        ],
      ),
    );
  }

//----------for selected variant-----------------------
//-------if price is 0 then no varint,so returns empty string
//-------if there is variant it finds the index of selected variant from 'selectedVariant'
//--------then returns the corresponding element of key at product.variants
  String getSelectedVariant() {
    var entries = product.variants.entries.toList();

    entries.sort((a, b) => a.value.compareTo(b.value));
    if (product.price == 0) {
      variantCubit.onSelectionChanged(entries.first.key);
    }

    int index = selectedVariant.indexWhere((element) => element);
    String variant =
        product.price != 0 ? '' : (index != -1 ? entries[index].key : '');
    return variant;
  }

//-------------callback for getting thecooking request----
  String getCookingRequest() => controller.text.trim();
  //------------callback for resetting the field------------
  void resetFields() {
    controller.clear();
    quantityBloc.add(QuantityResetEvent());
  }

  Row _buildQuantityAndParcelSection() {
    return Row(
      children: [
        Expanded(child: Quantity(bloc: quantityBloc)),
        ParcelChoicechip(
          cartBloc: cartBloc,
          getSelectedvarint: getSelectedVariant,
          product: product,
          quantityBloc: quantityBloc,
        ),
      ],
    );
  }

//-----------product name and price----------------
  Row _buildDishNameAndPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            Utils.capitalizeEachWord(product.name),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        product.price == 0
            ? BlocBuilder<SelectedVariantCubit, SelectedVariantState>(
                builder: (context, state) {
                  var selected =
                      (state as SelectedVariantInitialState).selected;
                  return Text(
                    '₹${Utils.calculateOffer(product, selected)}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  );
                },
              )
            : Text(
                '₹${Utils.calculateOffer(product)}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
      ],
    );
  }
}

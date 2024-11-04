import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/selected_variant/selected_variant_cubit.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/cooking_request_field.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/parcel_choice_chip.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/quantity.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/variant_selection_widget.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/add_to_cart_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';

showAddToCartBottomSheet(BuildContext context, ProductEntity product,
    [bool fromSearch = false]) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    elevation: 0,
    isScrollControlled: true,
    context: context,
    builder: (context) => AddToCart(
      product: product,
      fromSearch: fromSearch,
    ),
  );
}

class AddToCart extends StatefulWidget {
  ProductEntity product;
  bool fromSearch;
  AddToCart({super.key, required this.product, required this.fromSearch});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final TextEditingController controller = TextEditingController();

  List<bool> selectedVariant = [];

  String selected = '';

  var gap = const SizedBox(height: 10);

  late final CartManagementBloc cartBloc = CartManagementBloc();

  QuantityBloc quantityBloc = QuantityBloc();

  late SelectedVariantCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = context.read<SelectedVariantCubit>();
    intialise(context);
    return Padding(
      padding: Constants.padding10,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _pop(context),
            _elevatedContainer(context),
          ],
        ),
      ),
    );
  }

  _price(BuildContext context) {
    if (widget.product.price == 0) {
      return BlocBuilder<SelectedVariantCubit, SelectedVariantState>(
        builder: (context, state) {
          var selected = (state as SelectedVariantInitialState).selected;
          return Text(
            '₹${Utils.calculateOffer(widget.product, selected)}',
            style: TextStyle(color: Theme.of(context).primaryColor),
          );
        },
      );
    }
    return Text('₹${Utils.calculateOffer(widget.product)}',
        style: TextStyle(color: Theme.of(context).primaryColor));
  }

  GestureDetector _pop(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.of(context).pop(),
      child: const SizedBox.expand(),
    );
  }

  _elevatedContainer(BuildContext context) {
    return ElevatedContainer(
        child: Padding(
      padding: Constants.padding10,
      child: Wrap(
        runSpacing: 10,
        children: [
          _nameAndPrice(context),
          CookingRequestField(controller: controller),
          _variantSelectionWidget(),
          Row(
            children: [
              Expanded(child: Quantity(bloc: quantityBloc)),
              _parcelChip()
            ],
          ),
          _addToCartButton(),
        ],
      ),
    ));
  }

  Padding _nameAndPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(Utils.capitalizeEachWord(widget.product.name)),
          _price(context),
        ],
      ),
    );
  }

  VariantSelectionWidget _variantSelectionWidget() {
    return VariantSelectionWidget(
        product: widget.product,
        selectedVariant: selectedVariant,
        cartBloc: cartBloc,
        parcel: false);
  }

  ParcelChoicechip _parcelChip() {
    return ParcelChoicechip(
        quantityBloc: quantityBloc,
        cartBloc: cartBloc,
        product: widget.product,
        getSelectedvarint: getSelectedVariant);
  }

  AddToCartButton _addToCartButton() {
    return AddToCartButton(
        cartBloc: cartBloc,
        quantityBloc: quantityBloc,
        product: widget.product,
        getSelectedVariant: getSelectedVariant,
        cookingRequest: getCookingRequest,
        fromCart: false,
        fromSearch: widget.fromSearch,
        resetField: resetFields);
  }

  String getSelectedVariant() {
    var entries = widget.product.variants.entries.toList();

    entries.sort((a, b) => a.value.compareTo(b.value));
    if (widget.product.price == 0) {
      cubit.onSelectionChanged(entries.first.key);
    }

    int index = selectedVariant.indexWhere((element) => element);
    String variant = widget.product.price != 0
        ? ''
        : (index != -1 ? entries[index].key : '');
    return variant;
  }

  //-------------callback for getting thecooking request----
  String getCookingRequest() => controller.text.trim();

  //------------callback for resetting the field------------
  void resetFields() {
    controller.clear();
    quantityBloc.add(QuantityResetEvent());
  }

  void intialise(BuildContext context) {
    selectedVariant =
        List.generate(widget.product.variants.length, (index) => index == 0);
    context.read<SelectedVariantCubit>();
    cartBloc.add(CartManagementCheckForDuplicate(
        parcel: false,
        productId: widget.product.id,
        selectedVarinat: getSelectedVariant()));
  }
}

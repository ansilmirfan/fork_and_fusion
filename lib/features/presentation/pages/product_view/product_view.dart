import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/ingrediants.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/quantity.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/rating.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/variants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class ProductView extends StatelessWidget {
  ProductEntity product;
  ProductView({super.key, required this.product});
  List<bool> selectedVariant = [];

  @override
  Widget build(BuildContext context) {
    selectedVariant =
        List.generate(product.variants.length, (index) => index == 0);
    var gap = const SizedBox(height: 10);
    return BlocProvider(
      create: (context) => QuantityBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              _buildProductImage(),
              _buildDraggableSheet(context, gap),
              _buildGoBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea _buildGoBackButton(BuildContext context) {
    return SafeArea(
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }

//--------------images--------------
  SizedBox _buildProductImage() {
    return SizedBox(
      height: Constants.dHeight * 2 / 5,
      child: CarouselView(
        itemExtent: double.infinity,
        children: List.generate(
          product.image.length,
          (index) => Hero(
            tag: product.id + index.toString(),
            child: CacheImage(
              url: product.image[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableSheet(BuildContext context, SizedBox gap) {
    TextEditingController controller = TextEditingController();

    return DraggableScrollableSheet(
      initialChildSize: 0.66,
      minChildSize: 0.66,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
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
              _buildCookingRequestSection(context, gap, controller),
              gap,
              Variants(
                variants: product.variants,
                selectedVariant: selectedVariant,
              ),
              gap,
              _buildQuantityAndParcelSection(),
              gap,
              _buildAddToCartButton(),
            ],
          ),
        );
      },
    );
  }

  CustomTextButton _buildAddToCartButton() {
    return CustomTextButton(
      text: 'Add to Cart',
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {},
    );
  }

  Row _buildQuantityAndParcelSection() {
    return Row(
      children: [
        const Expanded(child: Quantity()),
        _parcelChoiceChip(),
      ],
    );
  }

  Expanded _parcelChoiceChip() {
    return Expanded(
      child: BlocBuilder<QuantityBloc, QuantityState>(
        builder: (context, state) {
          if (state is QuantityInitialState) {
            return ChoiceChip(
              label: const Text('Parcel'),
              selected: state.parcel,
              onSelected: (value) {
                context.read<QuantityBloc>().add(ParcelEvent());
              },
            );
          }
          return Constants.none;
        },
      ),
    );
  }

  Material _buildCookingRequestSection(
      BuildContext context, SizedBox gap, TextEditingController controller) {
    return Material(
      elevation: 10,
      borderRadius: Constants.radius,
      color: Theme.of(context).colorScheme.tertiary,
      child: Container(
        width: double.infinity,
        padding: Constants.padding10,
        child: Column(
          children: [
            const Text('Add a cooking Request (optional)'),
            gap,
            CustomTextField(
              hintText: "e.g. Don't make it too spicy",
              multiLine: 2,
              controller: controller,
            )
          ],
        ),
      ),
    );
  }

//-----------product name and price----------------
  Row _buildDishNameAndPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Utils.capitalizeEachWord(product.name),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          '₹${Utils.extractPrice(product)}',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}

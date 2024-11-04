import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/selected_variant/selected_variant_cubit.dart';
import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';

class VariantSelectionWidget extends StatelessWidget {
  final ProductEntity product;
  final List<bool> selectedVariant;
  final CartManagementBloc cartBloc;
  final bool parcel;

  const VariantSelectionWidget({
    super.key,
    required this.product,
    required this.selectedVariant,
    required this.cartBloc,
    required this.parcel,
  });

  @override
  Widget build(BuildContext context) {
    var entries = product.variants.entries.toList();
    // ------------Sort the entries by price
    entries.sort((a, b) => a.value.compareTo(b.value));

    return Visibility(
      visible: product.variants.isNotEmpty,
      child: ElevatedContainer(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: Constants.padding10,
          child: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                direction: Axis.horizontal,
                children: List.generate(
                  entries.length,
                  (index) {
                    final variantName = entries[index].key;

                    return ChoiceChip(
                      onSelected: (value) {
                        for (var i = 0; i < selectedVariant.length; i++) {
                          selectedVariant[i] = i == index;
                        }
                        context
                            .read<SelectedVariantCubit>()
                            .onSelectionChanged(variantName);
                        cartBloc.add(CartManagementCheckForDuplicate(
                          parcel: parcel,
                          productId: product.id,
                          selectedVarinat: variantName,
                        ));

                        setState(() {});
                      },
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      label: Text(
                          "$variantName   : ₹${Utils.calculateOffer(product, variantName)}  "),
                      selected: selectedVariant[index],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

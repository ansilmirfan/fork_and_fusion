import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/bloc/quantity_bloc/quantity_bloc.dart';

class ParcelChoicechip extends StatelessWidget {
  QuantityBloc quantityBloc;
  CartManagementBloc cartBloc;
 String Function() getSelectedvarint;
  ProductEntity product;
  ParcelChoicechip(
      {super.key,
      required this.quantityBloc,
      required this.cartBloc,
      required this.product,required this.getSelectedvarint});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<QuantityBloc, QuantityState>(
        bloc: quantityBloc,
        builder: (context, state) {
          if (state is QuantityInitialState) {
            return ChoiceChip(
              label: const Text('Parcel'),
              selected: state.parcel,
              onSelected: (value) {
                quantityBloc.add(ParcelEvent());
                cartBloc.add(CartManagementCheckForDuplicate(
                    parcel: value,
                    productId: product.id,
                    selectedVarinat: getSelectedvarint()));
              },
            );
          }
          return Constants.none;
        },
      ),
    );
  }
}

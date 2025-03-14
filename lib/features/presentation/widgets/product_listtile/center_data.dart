import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';

class CenterData {
  static Expanded productView(ProductEntity data, BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-----name----------
              Text(Utils.capitalizeEachWord(data.name)),
              //--------price------------
              Text(
                '₹${Utils.calculateOffer(data)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
              //-----------rating-------------
              Utils.calculateRating(data.rating) == 0
                  ? Text(
                      'Be the first to rate',
                      style: TextStyle(
                          fontSize: 13, color: Theme.of(context).primaryColor),
                    )
                  : Wrap(
                      children: List.generate(
                      Utils.calculateRating(data.rating),
                      (index) => Icon(Icons.star,color: Colors.amber,) ,
                    )
                      
                      ),
            ],
          ),
        ));
  }

  static Expanded cartView(CartEntity data, BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-----name----------
              Text(Utils.capitalizeEachWord(data.product.name)),
              //--------price------------
              Text(
                '₹${Utils.calculateOffer(data.product, data.selectedType)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),

              Visibility(
                visible: data.selectedType.isNotEmpty,
                child: Text('Type: ${data.selectedType}'),
              ),
              //------------if the product is available today then it shows parcel option otherwise not available
              data.product.type.contains(ProductType.todays_list)
                  ? ChoiceChip(
                      label: const Text('Parcel'),
                      selected: data.parcel,
                      onSelected: (value) {
                        context
                            .read<CartManagementBloc>()
                            .add(CartManagementUpdateParcelStatusEvent(data));
                      },
                    )
                  : Text(
                      'Not Available',
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
            ],
          ),
        ));
  }

  static Expanded historyView(BuildContext context, CartEntity cart) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-------product name------------
              Text(Utils.capitalizeEachWord(cart.product.name)),
              //-----------quantity--------------------
              Text('X ${cart.quantity}'),
              //--------------price---------------
              Text(
                '₹${Utils.calculateOffer(cart.product, cart.selectedType)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
              Visibility(
                  visible: cart.selectedType.isNotEmpty,
                  child: Text(cart.selectedType)),
              Visibility(visible: cart.parcel, child: Text('Parcel')),

              Visibility(
                visible: cart.status.isNotEmpty,
                child: Text(cart.status,
                    style: TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

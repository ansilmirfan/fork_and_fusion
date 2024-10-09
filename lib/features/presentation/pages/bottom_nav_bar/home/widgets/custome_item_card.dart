import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/widgets/add_to_cart_bottomsheet.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';

class CustomItemCard extends StatelessWidget {
  bool offer;
  String title;
  List<ProductEntity> data;
  CustomItemCard(
      {super.key, required this.data, required this.title, this.offer = true});

  @override
  Widget build(BuildContext context) {
    //-------------filtering data---------------------
    //-----------if offer is true ?filter based on the offer field in the object which is not equals to zero
    //-----------else  product type contains seasonal product-------------------
    offer
        ? data = data.where((element) => element.offer != 0).toList()
        : data = data
            .where((element) => element.type.contains(ProductType.seasonal))
            .toList();
    return Visibility(
      visible: data.isNotEmpty,
      child: SizedBox(
        height: Constants.dHeight * .26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _productCard(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _productCard(BuildContext context) {
    return Row(
      children: List.generate(
        data.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: Constants.radius,
            elevation: 10,
            color: Theme.of(context).colorScheme.tertiary,
            child: Stack(
              children: [
                Container(
                  width: Constants.dHeight * .18,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      _image(index),
                      _dishNameAndprice(context, index),
                    ],
                  ),
                ),
                _onTap(context, index),
                _addToCartButton(context, index)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned _addToCartButton(BuildContext context, int index) {
    return Positioned(
      right: 5,
      top: 5,
      child: SquareIconButton(
        height: 20,
        icon: Icons.add,
        white: false,
        onTap: () {
          showAddToCartBottomSheet(context, data[index]);
        },
      ),
    );
  }

  Positioned _onTap(BuildContext context, int index) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: Constants.radius,
          onTap: () {
            Navigator.of(context)
                .pushNamed('/productview', arguments: data[index]);
          },
        ),
      ),
    );
  }

  Expanded _dishNameAndprice(BuildContext context, int index) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          //---------dish name-----------------
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(Utils.capitalizeEachWord(data[index].name))),
            //------------amount----------------
            Row(
              mainAxisAlignment: offer
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                //------------extract price method for selecting the minimum value from varints
                //-----------or selecting the price directly
                Visibility(
                  visible: offer,
                  child: Text(
                    '₹${Utils.extractPrice(data[index])}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(decoration: TextDecoration.lineThrough),
                  ),
                ),

                //---------------------reducing the offer percentage from the actual price-----------------
                Text(
                  "₹${Utils.calculateOffer(data[index])}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded _image(int index) {
    return Expanded(
      flex: 2,
      child: ClipRRect(
        borderRadius: Constants.radius,
        child: SizedBox(
          width: double.infinity,
          child: CacheImage(
            url: data[index].image.first,
          ),
        ),
      ),
    );
  }
}

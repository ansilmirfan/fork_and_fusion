import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';

class CustomeItemCard extends StatelessWidget {
  double height;
  String title;
  bool offer;
  CustomeItemCard({
    super.key,
    required this.height,
    required this.title,
    this.offer = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * .26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //---------------title----------------
          Text(title),
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                //----------------products------------------
                child: Row(
                  children: List.generate(
                    10,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: Constants.radius,
                        elevation: 10,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Container(
                              width: height * .18,
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: Constants.radius,
                                      child: const CacheImage(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Column(
                                        //---------dish name-----------------
                                        children: [
                                          const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Dish name',
                                            ),
                                          ),
                                          //------------amount----------------
                                          Row(
                                            mainAxisAlignment: offer
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible: offer,
                                                child: Text(
                                                  '₹150',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                ),
                                              ),
                                              Text(
                                                '₹120',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: Constants.radius,
                                  onTap: () {},
                                ),
                              ),
                            ),
                            //----------add to cart---------------
                            Positioned(
                              right: 5,
                              top: 5,
                              child: SquareIconButton(
                                height: 20,
                                icon: Icons.add,
                                white: false,
                                onTap: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

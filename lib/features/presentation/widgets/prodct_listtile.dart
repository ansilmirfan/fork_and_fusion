import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';

class ProductListTile extends StatelessWidget {
  double height;
  ProductListTile({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        borderRadius: Constants.radius,
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/productview');
          },
          child: Container(
            height: height * 0.18,
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                SizedBox(
                  height: height * .18 - 5,
                  width: height * .18 - 5,
                  child: ClipRRect(
                    borderRadius: Constants.radius,
                    child: const CacheImage(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dish Name'),
                        Text(
                          '₹120',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                        const Wrap(
                          children: [
                            Icon(Icons.star_border_purple500),
                            Text('4.5')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                        ),
                        Expanded(
                          child: SquareIconButton(
                            icon: Icons.add,
                            height: 15,
                            white: false,
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

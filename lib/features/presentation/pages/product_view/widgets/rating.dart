import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

class Rating extends StatelessWidget {
  int rating;
  Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Theme.of(context).colorScheme.tertiary,
      borderRadius: Constants.radius,
      child: Padding(
        padding: const EdgeInsets.all(8.10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            5,
            (index) => (index + 1) <= rating
                ? const Icon(
                    Icons.star,
                    size: 40,
                    color: Colors.amber,
                  )
                : const Icon(
                    Icons.star_border,
                    size: 40,
                  ),
          ),
        ),
      ),
    );
  }
}

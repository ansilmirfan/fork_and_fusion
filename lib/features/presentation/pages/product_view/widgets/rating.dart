import 'package:flutter/material.dart';

import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';

class Rating extends StatelessWidget {
  int rating;
  Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      padding: 8.0,
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
    );
  }
}

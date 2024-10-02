import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

class Ingrediants extends StatelessWidget {
  String ingrediants;
  SizedBox gap;
  Ingrediants({super.key, required this.gap, required this.ingrediants});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: Constants.radius,
      elevation: 10,
      child: Container(
        width: double.infinity,
        padding: Constants.padding10,
        child: Column(
          children: [
            Text('Ingrediants',
                style: Theme.of(context).textTheme.headlineSmall),
            gap,
            Text(
              ingrediants,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

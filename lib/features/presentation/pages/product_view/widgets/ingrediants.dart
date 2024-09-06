import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

class Ingrediants extends StatelessWidget {
  SizedBox gap;
  Ingrediants({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: Constants.radius,
      elevation: 10,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Ingrediants',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            gap,
            const Text(
              'egg,water, breadcrumbs small onion,Dijon mustard, salt,Worcestershire sauce, pepper,lean ground beef,hamburger bun',
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

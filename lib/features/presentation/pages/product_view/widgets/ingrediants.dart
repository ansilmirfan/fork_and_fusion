import 'package:flutter/material.dart';

import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';

class Ingrediants extends StatelessWidget {
  String ingrediants;
  SizedBox gap;
  Ingrediants({super.key, required this.gap, required this.ingrediants});

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      padding: 10.0,
      child: SizedBox(
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

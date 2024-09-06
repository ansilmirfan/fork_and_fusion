import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth * .90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: constraints.maxWidth * .38,
              child: const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
            ),
            const Text('Or'),
            SizedBox(
              width: constraints.maxWidth * .38,
              child: const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

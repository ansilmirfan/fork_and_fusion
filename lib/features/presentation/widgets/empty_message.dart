import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final String message;
  const EmptyMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

void showCustomSnackbar(
    {required BuildContext context,
    required String message,
    bool isSuccess = true}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Icon(
          isSuccess ? Icons.check_circle : Icons.error,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
          ),
        ),
      ],
    ),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: Constants.padding10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    duration: const Duration(seconds: 3),
  ));
}

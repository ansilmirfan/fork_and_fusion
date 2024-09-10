import 'package:flutter/material.dart';

ratingDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      int sIndex = -1; 
      return AlertDialog(
        title: const Text('Rate this Dish'),
        content: const Text('How would you rate this dish?'),
        actions: [
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      5,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            sIndex = index;
                          });
                        },
                        child: Icon(
                          sIndex >= index ? Icons.star : Icons.star_border,
                          color: sIndex >= index ? Colors.amber : Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                        
                          Navigator.of(context).pop();
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      );
    },
  );
}

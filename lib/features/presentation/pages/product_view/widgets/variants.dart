import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

class Variants extends StatelessWidget {
  Map<String, dynamic> variants;
  List<bool> selectedVariant;
  Variants({super.key, required this.variants, required this.selectedVariant});

  @override
  Widget build(BuildContext context) {
    var keys = variants.keys.toList();
    return Visibility(
      visible: variants.isNotEmpty,
      child: Material(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: Constants.radius,
        elevation: 10,
        child: Container(
            padding: Constants.padding10,
            child: StatefulBuilder(
              builder: (context, setState) => Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(
                  keys.length,
                  (index) => ChoiceChip(
                    onSelected: (value) {
                      for (var i = 0; i < selectedVariant.length; i++) {
                        selectedVariant[i] = i == index;
                      }
                      setState(() {});
                    },
                    selectedColor: Theme.of(context).colorScheme.secondary,
                    label:
                        Text("${keys[index]}   : ₹${variants[keys[index]]}  "),
                    selected: selectedVariant[index],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

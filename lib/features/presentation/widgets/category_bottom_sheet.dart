import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';

categoryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        snap: true,
        builder: (context, scrollController) {
          var isSelected = false;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 224, 224),
                borderRadius: Constants.radius,
              ),
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.white,
                    borderRadius: Constants.radius,
                    elevation: 10,
                    child: StatefulBuilder(
                      builder: (context, setState) => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('category'),
                        value: isSelected,
                        onChanged: (value) {
                          setState(
                            () => isSelected = !isSelected,
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

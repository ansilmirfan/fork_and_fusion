import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';

class CookingRequestField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  CookingRequestField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      padding: 10.0,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Text('Add a cooking Request (optional)'),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "e.g. Don't make it too spicy",
              multiLine: 2,
              controller: controller,
            )
          ],
        ),
      ),
    );
  }
}
